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
        safeAreaYCoordinate: CGFloat
    )
}

protocol MenuSceneDataStore {
    
}

final class MenuSceneInteractor: MenuSceneBusinessLogic, MenuSceneDataStore {
    var presenter: MenuScenePresentationLogic?
    var networkWorker: NetworkWorker?
    
    func fetchProducts(request: MenuSceneModels.Request) {
        networkWorker = NetworkWorker()
        var products = GroupedProducts(
            categoriesAndNames: [:],
            dividedProducts: [:]
        )
        var categories = [Category]()
        let group = DispatchGroup()
        
        group.enter()
        networkWorker?.fetchCategories { result in
            switch result {
            case .success(let fetchedCategories):
                categories = fetchedCategories
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        networkWorker?.fetchCategoriesWithProducts { [weak self] result in
            switch result {
            case .success(let groupedProducts):
                products = groupedProducts
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.presenter?.configureCategories(categories: categories)
            self.presenter?.presentMenu(
                response: MenuSceneModels.Response(groupedProducts: products)
            )
        }
    }
    
    func sendScrollStateToPresenter(
        scrollView: UIScrollView,
        safeAreaYCoordinate: CGFloat
    ) {
        presenter?.scrollViewScrolled(
            scrollView: scrollView,
            safeAreaYCoordinate: safeAreaYCoordinate
        )
    }
}
