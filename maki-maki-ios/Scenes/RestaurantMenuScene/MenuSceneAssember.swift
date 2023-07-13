//
//  MenuSceneAssembly.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 14.07.2023.
//

import Foundation

final class MenuSceneAssembler {
    
    func assemble(_ viewController: MenuSceneViewController) {
        let interactor = MenuSceneInteractor()
        let presenter = MenuScenePresenter()
        let router = MenuSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
