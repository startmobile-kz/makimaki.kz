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
    var searchHistory: [History] = []
    
    var filteredProducts = [SearchProduct]() {
        didSet{
            self.bind()
        }
    }
    
    var reloadDataCallback: (() -> Void)?
    
    func bind() {
        reloadDataCallback?()
    }
    
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
    
//    func getSearchResultViewModel(forIndexPath indexPath: IndexPath) -> SearchResultCellViewModel {
//    }
}
