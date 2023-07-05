//
//  WelcomePageService.swift
//  maki-maki-ios
//
//  Created by siberianarg on 03.07.2023.
//

import Foundation
import Alamofire

class WelcomePageService {
    
    // MARK: - Network With Alamofire
    
    private func authorizeWithAlamofire(phoneNumber: String, deviceID: String) {
        let urlString = "https://app.makimaki.kz/api/v1/client/phone-confirmation/request"
        
        let parameters: [String: Any] = [
            "uuid": deviceID,
            "phone": phoneNumber
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                if let error = response.error {
                    print(error)
                } else if let data = response.data {
                    let jsonData = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonData)
                }
            }
    }
}
