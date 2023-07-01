//
//  DishResponseModel.swift
//  maki-maki-ios
//
//  Created by Tami on 20.06.2023.
//

import Foundation

class RestaurantProduct: Codable {
    let id: Int
    let name: String
    let description: String
    let category: Int
    let price: Int
    let image: String?
    var isSelected: Bool = false
    var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, category, price, image
    }
    
    init(id: Int,
         name: String,
         description: String,
         category: Int,
         price: Int,
         image: String?,
         isSelected: Bool,
         count: Int) {
        
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.price = price
        self.image = image
        self.isSelected = isSelected
        self.count = count
    }
}
