//
//  Basket.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.
//

import Foundation

struct Basket: Codable {
    var uuid: String
    var fullName: String
    var phone: String
    var address: String
    var promoCode: String
    var comment: String
    var basket: [String: Int]
    var code: String
}

enum CodingKeys: String, CodingKey {
    case fullName = "full_name"
    case promoCode = "promo_code"
}
