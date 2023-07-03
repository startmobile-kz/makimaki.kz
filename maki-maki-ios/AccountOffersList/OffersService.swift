//
//  OffersService.swift
//  maki-maki-ios
//
//  Created by Ravil on 03.07.2023.
//

import Foundation
import Alamofire

class OffersService {

    func fetchOffers(completion: @escaping (Result<[Offers], AFError>) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/promo-codes/details"
        guard let url = URL(string: urlString) else { return }

        AF.request(url, method: .get).responseDecodable(of: [Offers].self) { data in
            completion(data.result)
        }
    }
}
