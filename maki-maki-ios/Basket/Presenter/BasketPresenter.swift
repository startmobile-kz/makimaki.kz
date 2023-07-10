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

class BasketPresenter: BasketPresenterProtocol {
    weak var view: BasketViewProtocol?
    var router: BasketRouterProtocol?
    var basketInteractor: BasketInteractorProtocol

    init(view: BasketViewProtocol, basketInteractor: BasketInteractorProtocol = BasketInteractor()) {
        self.view = view
        self.basketInteractor = basketInteractor
    }
    
    var selectedDishes: [RestaurantProduct] = [] // Replace with your implementation
    
    func setSelectedDishes(selectedDishes: [RestaurantProduct]) {
        self.selectedDishes = selectedDishes
    }
    
    func getSelectedDishes() {
        view?.showSelectedDishes(selectedDishes)
        
        let totalPrice = calculateTotalPrice(selectedDishes)
        view?.showTotalPrice(totalPrice)
    }
    
    func deleteSelectedDish(at indexPath: IndexPath) {
        // Delete the selected dish at the given index path from the data source
        // ...
        selectedDishes.remove(at: indexPath.row)
        view?.showSelectedDishes(selectedDishes)
        
        let totalPrice = calculateTotalPrice(selectedDishes)
        view?.showTotalPrice(totalPrice)
    }
    
    func createOrder() {
        // Create a Basket object with the necessary details
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
        // Calculate the total price of the selected dishes
        var totalPrice = 0
        for dish in dishes {
            totalPrice += dish.count * dish.price
        }
        return totalPrice
    }
}
