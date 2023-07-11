//
//  MenuSceneInteractor.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation

protocol MenuSceneBusinessLogic {
    func fetchProducts(request: MenuSceneModels.Request)
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
}
