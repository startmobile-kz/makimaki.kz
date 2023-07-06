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
