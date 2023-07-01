//
//  ProductService.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 21.06.2023.
//

import Foundation

// MARK: - Network request for products

class ProductsService {
    
    private var urlSession = URLSession.shared
    
    func fetchProducts(completion: @escaping ([Product]) -> Void) {
        
        let urlString = "https://app.makimaki.kz/api/v1/client/products"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data else {
                fatalError("Data not found")
            }
            do {
                let product = try JSONDecoder().decode([Product].self, from: data)
                completion(product)
            } catch let error {
                print("Error:\(error.localizedDescription)")
                completion([])
            }
        }
        )
        task.resume()
    }
}
