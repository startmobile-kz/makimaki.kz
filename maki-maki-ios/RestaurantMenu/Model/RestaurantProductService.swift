//
//  DishService.swift
//  maki-maki-ios
//
//  Created by Tami on 20.06.2023.
//

import Foundation
import Alamofire

// MARK: - Network request for products

class RestaurantProductService {
    
    private var urlSession = URLSession.shared
    
    func fetchCategoriesWithProducts(
        completion: @escaping (Result<GroupedProducts, AFError>) -> Void
    ) {
        var categoriesAndNames: [Int: String] = [:]
        var productsByCategoryMap: [Int: [RestaurantProduct]] = [:]
        
        fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                for category in categories {
                    categoriesAndNames[category.id] = category.name
                }
                
                self?.fetchProductsWithAlamofire(completion: { result in
                    switch result {
                    case .success(let products):
                        for product in products {
                            if productsByCategoryMap[product.category] == nil {
                                productsByCategoryMap[product.category] = [product]
                            } else {
                                productsByCategoryMap[product.category]?.append(product)
                            }
                        }
                        let groupedProducts = GroupedProducts(
                            categoriesAndNames: categoriesAndNames,
                            dividedProducts: productsByCategoryMap
                        )
                        completion(.success(groupedProducts))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCategories(completion: @escaping (Result<[Category], AFError>) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/categories"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [Category].self) { data in
                completion(data.result)
            }
    }
    
    func fetchProductsWithAlamofire(completion: @escaping (Result<[RestaurantProduct], AFError>) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/products"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [RestaurantProduct].self) { data in
                completion(data.result)
            }
    }
    
    func fetchProducts(completion: @escaping ([RestaurantProduct]) -> Void) {
        
        let urlString = "https://app.makimaki.kz/api/v1/client/products"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data else {
                fatalError("Data not found")
            }
            
            do {
                let dishes = try JSONDecoder().decode([RestaurantProduct].self, from: data)
                completion(dishes)
                
            } catch let error {
                print("Error:\(error.localizedDescription)")
            }
        }
        )
        task.resume()
    }
}
