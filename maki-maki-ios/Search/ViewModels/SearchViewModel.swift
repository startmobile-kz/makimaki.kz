//
//  SearchViewModel.swift
//  maki-maki-ios
//
//  Created by Tami on 12.07.2023.
//

import Foundation

class SearchViewModel {
    
    let service = ProductsService()
    var products: [SearchProduct] = []
    
    var filteredProducts = [SearchProduct]() {
        didSet {
        }
    }
    
    var searchHistory: [History] = []
    
    func fetchProducts() {
        service.fetchProductsWithAlamofire { products in
            DispatchQueue.main.async { [weak self] in
                self?.products = products
                self?.filteredProducts = products
            }
        }
    }
    
    func addToHistory(name: String) {
        let history = History(name: name)
        searchHistory.append(history)
    }
}
