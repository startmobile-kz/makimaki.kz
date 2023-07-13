//
//  BasketScenePresenter.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation

protocol BasketScenePresentationLogic {
    func presentSelectedProducts(selectedProducts: [RestaurantProduct])
}

class BasketScenePresenter: BasketScenePresentationLogic {
    
    weak var viewController: BasketSceneDisplayLogic?
    
    func presentSelectedProducts(selectedProducts: [RestaurantProduct]) {
        viewController?.displaySelectedProducts(selectedProducts: selectedProducts)
    }
}
