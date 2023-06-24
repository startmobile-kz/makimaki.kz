//
//  BasketModel.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.
//

import Foundation

struct BasketModel: Codable {
    var full_name: String
    var phone: String
    var address: String
    var promo_code: String
    var basket: [String: Int]
    var code: String
}

let basketModel = BasketModel(full_name: "Alex", phone: "87022185321", address: "Pushkina", promo_code: "", basket: ["4" : 1, "15" : 3], code: "1234")
