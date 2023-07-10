//
//  BasketRouter.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 10.07.2023.
//

import UIKit
import Foundation

protocol BasketRouterProtocol {
    // Define your routing methods here
    // ...
}

class BasketRouter: BasketRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = BasketViewController()
        let interactor = BasketService()
        let presenter = BasketPresenter(view: view)
        let router = BasketRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.basketService = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // Implement your routing methods here
    // ...
}
