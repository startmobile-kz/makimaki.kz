//
//  BasketSceneInteractor.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation

protocol BasketSceneBusinessLogic {
    func getSelectedProducts()
}

protocol BasketSceneDataStore: AnyObject {
    var selectedProducts: [RestaurantProduct]? { get set }
}

class BasketSceneInteractor: BasketSceneBusinessLogic, BasketSceneDataStore {
    var presenter: BasketScenePresentationLogic?
    
    var selectedProducts: [RestaurantProduct]?
    
    func getSelectedProducts() {
        presenter?.presentSelectedProducts(selectedProducts: selectedProducts ?? [])
    }
}
