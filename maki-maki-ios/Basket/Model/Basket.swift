//
//  Basket.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.
//

import Foundation

struct Basket: Codable {
    var full_name: String
    var phone: String
    var address: String
    var promo_code: String
    var basket: [String: Int]
    var code: String
    var uuid: String
    var comment: String
}
