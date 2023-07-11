//
//  BasketService.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.

import Foundation
import Alamofire

protocol BasketServiceProtocol {
    func createOrder(with basket: Basket, completion: @escaping (Bool) -> Void)
}

// MARK: - Service

final class BasketService: BasketServiceProtocol {
    func createOrder(with basket: Basket, completion: @escaping (Bool) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/orders"
        guard let url = URL(string: urlString) else { return }
        
        let body = ["uuid": basket.uuid,
                    "full_name": basket.fullName,
                    "phone": basket.phone,
                    "address": basket.address,
                    "promoCode": basket.promoCode,
                    "comment": basket.comment,
                    "basket": basket.basket,
                    "code": basket.code] as [String: Any]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure(let error):
                    print("Error \(error)")
                    print(body)
                    completion(false)
                }
            }
    }
}
