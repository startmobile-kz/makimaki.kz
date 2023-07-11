//
//  BasketSceneRouter.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation

protocol BasketSceneRoutingLogic {
    
}

protocol BasketSceneDataPassing {
    var dataStore: BasketSceneDataStore? { get set }
}

class BasketSceneRouter: BasketSceneRoutingLogic, BasketSceneDataPassing {
    weak var dataStore: BasketSceneDataStore?
}
