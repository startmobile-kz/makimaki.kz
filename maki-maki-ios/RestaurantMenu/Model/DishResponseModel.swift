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
    let image: String?
}