//
//  BasketInteractor.swift
//  maki-maki-ios
//
//  Created by siberianarg on 10.07.2023.
//

import Foundation

protocol BasketInteractorProtocol {
    func createOrder(with basket: Basket, completion: @escaping (Bool) -> Void)
}

final class BasketInteractor: BasketInteractorProtocol {
    var basketService: BasketServiceProtocol
    
    // MARK: - Lifecycle
    
    init(basketService: BasketServiceProtocol = BasketService()) {
        self.basketService = basketService
    }
    
    // MARK: - Logic
    
    func createOrder(with basket: Basket, completion: @escaping (Bool) -> Void) {
        basketService.createOrder(with: basket) { isSuccess in
            completion(isSuccess)
        }
    }
}
