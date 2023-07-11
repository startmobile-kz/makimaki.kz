//
//  Basket.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.
//

import Foundation

struct Basket: Codable {
    let uuid: String
    let fullName: String
    let phone: String
    let address: String
    let promoCode: String
    let comment: String
    let basket: [String: Int]
    let code: String
}

enum CodingKeys: String, CodingKey {
    case fullName = "full_name"
    case promoCode = "promo_code"
}
