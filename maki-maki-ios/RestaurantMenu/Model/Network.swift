//
//  Network.swift
//  maki-maki-ios
//
//  Created by Tami on 20.06.2023.
//

import Foundation

class Networking {
    
    private var urlSession = URLSession.shared
    var backendDishes: [DishResponseModel] = []
    
    func fetchAPI() {
        
        let urlString = "https://app.makimaki.kz/api/v1/client/products"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.dataTask(with: request, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                print(data)
                let dishes = try JSONDecoder().decode([DishResponseModel].self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.backendDishes = dishes
                }
            } catch {
                print("Error:\(error.localizedDescription)")
            }
        }
        )
        task.resume()
        
    }
}
