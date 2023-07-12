//
//  SearchResultCellViewModel.swift
//  maki-maki-ios
//
//  Created by Tami on 12.07.2023.
//

import Foundation

class SearchResultCellViewModel {
    let productName: String?
    let productPrice: String?
    let productImageURL: URL?
    
    init(product: SearchProduct) {
        productName = product.name
        productPrice = "\(product.price) ₸"
        productImageURL = URL(string: product.image ?? "")
    }
}
