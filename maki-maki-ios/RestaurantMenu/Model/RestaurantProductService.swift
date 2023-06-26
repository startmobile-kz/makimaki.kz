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
