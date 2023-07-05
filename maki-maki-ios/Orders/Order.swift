//
//  Order.swift
//  maki-maki-ios
//
//  Created by siberianarg on 06.06.2023.
//

import Foundation

struct Order {
    let cafeName: String
    let status: String
    let time: String
    let price: String
    var ordersList: [OrdersList]
}

// struct OrdersModel: Decodable {
//    var status: Int
//    var createdAt: String
//    var finalTotal: Int
//    var commonTotal: Int
//    var name: String
//    
//    enum CodingKeys: String, CodingKey {
//        case status = "status"
//        case createdAt = "created_at"
//        case finalTotal = "final_total"
//        case commonTotal = "common_total"
//        case name = "full_name"
//        
//    }
// } 
