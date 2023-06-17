//
//  OrdersModel.swift
//  maki-maki-ios
//
//  Created by siberianarg on 06.06.2023.
//

import Foundation

struct OrdersModel {
    let cafeName: String
    let status: String
    let time: String
    let price: String
    var ordersList: [OrdersList]
}

struct OrdersModelNew: Decodable {
    var id: Int
    var status: Int
    var createdAt: String
    var total: Int
    var name: String
    var promoCode: String
    //    var ordersList: [OrdersList]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case status = "status"
        case createdAt = "created_at"
        case total = "final_total"
        case name = "full_name"
        case promoCode = "promo_code"

    }
}
