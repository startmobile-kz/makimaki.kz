//
//  BasketPresenter.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 10.07.2023.
//

import Foundation

protocol BasketPresenterProtocol {
    func setSelectedDishes(selectedDishes: [RestaurantProduct])
    func getSelectedDishes()
    func deleteSelectedDish(at indexPath: IndexPath)
    func createOrder()
}

final class BasketPresenter: BasketPresenterProtocol {
    weak var view: BasketViewProtocol?
    var router: BasketRouterProtocol?
    var basketInteractor: BasketInteractorProtocol
    var selectedDishes: [RestaurantProduct] = []
    
    // MARK: - Lifecycle
    
    init(view: BasketViewProtocol, basketInteractor: BasketInteractorProtocol = BasketInteractor()) {
        self.view = view
        self.basketInteractor = basketInteractor
    }
    
    // MARK: - Logic
    
    func setSelectedDishes(selectedDishes: [RestaurantProduct]) {
        self.selectedDishes = selectedDishes
    }
    
    func getSelectedDishes() {
        view?.showSelectedDishes(selectedDishes)
        
        let totalPrice = calculateTotalPrice(selectedDishes)
        view?.showTotalPrice(totalPrice)
    }
    
    func deleteSelectedDish(at indexPath: IndexPath) {
        selectedDishes.remove(at: indexPath.row)
        view?.showSelectedDishes(selectedDishes)
        
        let totalPrice = calculateTotalPrice(selectedDishes)
        view?.showTotalPrice(totalPrice)
    }
    
    func createOrder() {
        let basket = Basket(uuid: "151eb4a0-ff99-4482-90d2-c4e7c77810dc",
                            fullName: "Разработчик тестирует заказ",
                            phone: "77082020155",
                            address: "Разработчик тестирует заказ",
                            promoCode: "BURGER",
                            comment: "Разработчик тестирует заказ",
                            basket: ["6": 1, "17": 2, "23": 4],
                            code: "8146")
        
        basketInteractor.createOrder(with: basket) { [weak self] isSuccess in
            if isSuccess {
                self?.view?.showOrderSuccess()
            } else {
                self?.view?.showOrderFailure()
            }
        }
    }
    
    private func calculateTotalPrice(_ dishes: [RestaurantProduct]) -> Int {
        var totalPrice = 0
        for dish in dishes {
            totalPrice += dish.count * dish.price
        }
        return totalPrice
    }
}
