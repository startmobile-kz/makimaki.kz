//
//  OderModel.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 05.07.2023.
//

import Foundation

enum OrderStatus: Int, Decodable {
    case created = 1
    case awaitingCustomerResponse = 2
    case accepted = 3
    case preparing = 4
    case inTransit = 5
    case delivered = 6
    case cancelled = 7
}

 struct OrdersModel: Decodable {
    var status: OrderStatus
    var createdAt: String
    var finalTotal: Int
    var commonTotal: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case createdAt = "created_at"
        case finalTotal = "final_total"
        case commonTotal = "common_total"
        case name = "full_name"
        
    }
 }
