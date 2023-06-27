//
//  DishService.swift
//  maki-maki-ios
//
//  Created by Tami on 20.06.2023.
//

import Foundation

// MARK: - Network request for products

class RestaurantProductService {
    
    private var urlSession = URLSession.shared
    
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
