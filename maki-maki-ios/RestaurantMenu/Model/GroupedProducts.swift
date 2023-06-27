//
//  GroupedProducts.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 27.06.2023.
//

import Foundation

struct GroupedProducts {
    let categoriesAndNames: [Int: String]
    let dividedProducts: [Int: [RestaurantProduct]]
}
