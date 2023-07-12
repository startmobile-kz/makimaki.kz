//
//  ProductModel.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 21.06.2023.
//

import Foundation

struct SearchProduct: Decodable {
    let id: Int
    let name: String
    let description: String
    let category: Int
    let price: Int
    let image: String?
}
