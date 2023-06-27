//
//  DishService.swift
//  maki-maki-ios
//
//  Created by Tami on 20.06.2023.
//

import Foundation
import Alamofire

// MARK: - Network request for products

enum NetworkErrors: Error {
    case badUrl
    case serverError
}

class RestaurantProductService {
    
    private var urlSession = URLSession.shared
    
    func fetchCategoriesWithProduct(
        completion: @escaping (Result<GroupedProducts>) -> Void
    ) {
        var categoriesAndNames: [Int: String] = [:]
        var productsByCategoryMap: [Int: [RestaurantProduct]] = [:]
        
        fetchCategories { [weak self] result in
            switch result {
            case .success(data: let categories):
                guard let categories = categories else {
                    completion(.error(message: "Incorrect categories data."))
                    return
                }
                for category in categories {
                    categoriesAndNames[category.id] = category.name
                }
                
                self?.fetchProductsWithAlamofire(completion: { result in
                    switch result {
                    case .success(data: let products):
                        guard let products = products else {
                            completion(.error(message: "Incorrect products data."))
                            return
                        }
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
                        completion(.success(data: groupedProducts))
                    case .error(message: let message):
                        completion(.error(message: message))
                    }
                })
                
            case .error(message: let message):
                completion(.error(message: message))
            }
        }
    }
    
    func fetchCategories(completion: @escaping (Result<[Category]>) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/categories"
        
        guard let url = URL(string: urlString) else {
            completion(.error(message: "Invalid URL."))
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [Category].self) { data in
                switch data.result {
                case .success(let categories):
                    completion(.success(data: categories))
                case .failure(let error):
                    completion(.error(message: error.localizedDescription))
                }
            }
    }
    
    func fetchProductsWithAlamofire(completion: @escaping (Result<[RestaurantProduct]>) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/products"
        
        guard let url = URL(string: urlString) else {
            completion(.error(message: "Invalid URL."))
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [RestaurantProduct].self) { data in
                switch data.result {
                case .success(let products):
                    completion(.success(data: products))
                case .failure(let error):
                    completion(.error(message: error.localizedDescription))
                }
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
