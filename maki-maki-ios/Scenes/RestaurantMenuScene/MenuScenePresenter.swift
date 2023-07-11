//
//  MenuScenePresenter.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation

protocol MenuScenePresentationLogic {
    func presentMenu(response: MenuSceneModels.Response)
}

final class MenuScenePresenter: MenuScenePresentationLogic {
    weak var viewController: MenuSceneDisplayLogic?
    
    func presentMenu(response: MenuSceneModels.Response) {
        let viewModel = MenuSceneModels.ViewModel(
            categoriesAndNames: response.groupedProducts.categoriesAndNames,
            dividedProducts: response.groupedProducts.dividedProducts)
        viewController?.displayMenu(viewModel: viewModel)
    }
}
