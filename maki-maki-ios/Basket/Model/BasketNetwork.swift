//
//  BasketNetwork.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.
//

import Foundation

class BasketNetwork {
    
    private var urlSession = URLSession.shared
    
    func checkoutPost(completion: @escaping ([BasketModel]) -> Void) {
        
        let urlString = "https://app.makimaki.kz/api/v1/client/orders"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = BasketModel()
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error \(error)")
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("\(dataString)")
            }
        }
        task.resume()
    }
}

