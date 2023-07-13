//
//  NetworkWorker.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import UIKit
import Alamofire

final class NetworkWorker {
    
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
                
                self?.fetchProducts(completion: { result in
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
    
    func fetchProducts(completion: @escaping (Result<[RestaurantProduct], AFError>) -> Void) {
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
}
