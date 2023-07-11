//
//  BasketRouter.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 10.07.2023.
//

import UIKit
import Foundation

protocol BasketRouterProtocol {
    
}

final class BasketRouter: BasketRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = BasketViewController()
        let interactor = BasketInteractor()
        let presenter = BasketPresenter(view: view)
        let router = BasketRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.basketInteractor = interactor
        presenter.router = router
        router.viewController = view
        return view
    }
}
