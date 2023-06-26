//
//  BasketService.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.
//

import Foundation

class BasketService {

    private var urlSession = URLSession.shared

    func createOrder(with basket: Basket, completion: @escaping (Bool) -> Void) {
        
        let urlString = "https://app.makimaki.kz/api/v1/client/orders"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)

        let body = ["uuid": basket.uuid,
                    "full_name": basket.fullName,
                    "phone": basket.phone,
                    "address": basket.address,
                    "promoCode": basket.promoCode,
                    "comment": basket.comment,
                    //"basket": basket.basket,
                    "code": basket.code]
        let bodyJson = try? JSONSerialization.data(withJSONObject: body)

        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = bodyJson

        let task = urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error \(error)")
                completion(false)
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("\(dataString)")
                if dataString.contains("Неверный код") {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
        task.resume()
    }
}
