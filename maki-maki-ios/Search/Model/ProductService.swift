//
//  ProductService.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 21.06.2023.
//

import Foundation
import Alamofire

// MARK: - Network request for products

class ProductsService {
        
    func fetchProductsWithAlamofire(completion: @escaping ([Product]) -> Void) {
        
        let urlString = "https://app.makimaki.kz/api/v1/client/products"
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).validate().responseDecodable(of: [Product].self) { data in
            switch data.result {
            case .success(let product):
                completion(product)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
