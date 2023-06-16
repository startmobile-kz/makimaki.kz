//
//  AuthEndpoint.swift
//  maki-maki-ios
//
//  Created by Shyngys on 12.06.2023.
//

import Foundation
import Moya

enum AuthEndpoint {
    case login(parameters: [String: String])
    case registration(parameters: [String: String])
    case changePassword(parameters: [String: String])
}

extension AuthEndpoint: TargetType {
    
    var headers: [String: String]? {
        
        switch self {
        case .changePassword:
            //            let token = StorageManager.shared.getToken()
            return ["Authorization" : "Bearer token"]
        default:
            return [:]
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://nazaredu.site/api/v1/users/")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "get-token/"
        case .registration:
            return "register-user/"
        case .changePassword:
            return "change-password/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .changePassword:
            return .put
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let parameters),
                .registration(let parameters),
                .changePassword(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
