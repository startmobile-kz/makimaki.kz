//
//  MenuSceneInteractor.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation
import UIKit

protocol MenuSceneBusinessLogic {
    func fetchProducts(request: MenuSceneModels.Request)

    func sendScrollStateToPresenter(
        scrollView: UIScrollView,
        safeAreaYCoordinate: CGFloat,
        heights: [Double]
    )
}

protocol MenuSceneDataStore {
    
}

final class MenuSceneInteractor: MenuSceneBusinessLogic, MenuSceneDataStore {
    var presenter: MenuScenePresentationLogic?
    var networkWorker: NetworkWorker?
    
    func fetchProducts(request: MenuSceneModels.Request) {
        networkWorker = NetworkWorker()
        networkWorker?.fetchCategoriesWithProducts { [weak self] result in
            switch result {
            case .success(let groupedProducts):
                self?.presenter?.presentMenu(
                    response: MenuSceneModels.Response(groupedProducts: groupedProducts)
                )
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendScrollStateToPresenter(
        scrollView: UIScrollView,
        safeAreaYCoordinate: CGFloat,
        heights: [Double]
    ) {
        presenter?.scrollViewScrolled(
            scrollView: scrollView,
            safeAreaYCoordinate: safeAreaYCoordinate,
            heights: heights
        )
    }
}
