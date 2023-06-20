//
//  DishResponseModel.swift
//  maki-maki-ios
//
//  Created by Tami on 20.06.2023.
//

import Foundation

struct DishResponseModel: Decodable {
    
    let id: Int
    let name: String
    let description: String
    let category: Int
    let price: Int
    let has_discount: Int
    let order_by_default: Int
    let order_by_popularity: Int
    let tags: String?
    let image: String
    let disabled: Int
}
