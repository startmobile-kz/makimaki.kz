//
//  MenuSceneRouter.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import UIKit

protocol MenuSceneRoutingLogic {
    func navigateToBasket(destination: BasketSceneViewController)
    func presentProduct(destination: DishViewController)
}

protocol MenuSceneDataPassing {
    var dataStore: MenuSceneDataStore? { get }
}

class MenuSceneRouter: MenuSceneRoutingLogic, MenuSceneDataPassing {
    weak var viewController: MenuSceneViewController?
    var dataStore: MenuSceneDataStore?
    
    func navigateToBasket(destination: BasketSceneViewController) {
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
    
    func presentProduct(destination: DishViewController) {
        viewController?.present(destination, animated: true)
    }
}
