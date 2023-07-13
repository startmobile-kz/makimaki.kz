//
//  BasketSceneAssembler.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 14.07.2023.
//

import Foundation

final class BasketSceneAssembler {
    
    func assemble(_ viewController: BasketSceneViewController) {
        let interactor = BasketSceneInteractor()
        let presenter = BasketScenePresenter()
        let router = BasketSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
