//
//  BasketModel.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 23.06.2023.
//

import Foundation

struct BasketModel: Decodable {
    var full_name: String = ""
    var phone: String = ""
    var address: String = ""
    var promo_code: String = ""
    var code: String = ""
}
