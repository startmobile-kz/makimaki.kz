//
//  OrderService.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 05.07.2023.
//

import Foundation
import Alamofire

 class OrderService {
     
     func getOrdersOfAlamofire(completion: @escaping (Result<[OrdersModel], AFError>) -> Void) {
        let urlString =
         "https://app.makimaki.kz/api/v1/client/orders?uuid=151eb4a0-ff99-4482-90d2-c4e7c77810dc"
        guard let url = URL(string: urlString) else { return }
         
        AF.request(url).responseDecodable(of: [OrdersModel].self) { data in
            completion(data.result)
        }
    }
 }
