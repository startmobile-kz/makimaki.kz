//
//  OderModel.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 05.07.2023.
//

import Foundation

 struct OrdersModel: Decodable {
    var status: Int
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
