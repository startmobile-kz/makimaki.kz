//
//  MenuSceneModels.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation

enum MenuSceneModels {
    // ViewController -> Interactor
    struct Request {}
    // Interactor -> Presenter
    struct Response: Codable {
        let groupedProducts: GroupedProducts
    }
    // Presenter -> ViewController
    struct ViewModel {
        let categoriesAndNames: [Int: String]
        let dividedProducts: [Int: [RestaurantProduct]]
    }
}
