//
//  CategoryService.swift
//  maki-maki-ios
//
//  Created by Ravil on 21.06.2023.
//

import Foundation
import Alamofire

class CategoryService {

    func fetchCategories(completion: @escaping (Result<[Category], AFError>) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/categories"
        guard let url = URL(string: urlString) else { return }

        AF.request(url, method: .get).responseDecodable(of: [Category].self) { data in
            completion(data.result)
        }
    }
}
