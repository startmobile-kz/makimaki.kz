//
//  Server.swift
//  maki-maki-ios
//
//  Created by Shyngys on 11.06.2023.
//

import Foundation
import UIKit
import Alamofire
import Moya

struct Server {
    
    static let shared = Server()
    
    private(set) var provider =
        MoyaProvider<MultiTarget>(endpointClosure: { (target: TargetType) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: MultiTarget(target))
        switch defaultEndpoint.task {
        case .requestParameters(var params, let encoding):
            var header = defaultEndpoint.httpHeaderFields
            return Endpoint(url: defaultEndpoint.url,
                            sampleResponseClosure: defaultEndpoint.sampleResponseClosure,
                            method: defaultEndpoint.method,
                            task: .requestParameters(parameters: params, encoding: encoding),
                            httpHeaderFields: header)
        default:
            return defaultEndpoint
        }
    }, callbackQueue: DispatchQueue.global(qos: .utility))
    
    func request<T: Codable>(target: TargetType,
                             parser: Parsing = Parser.shared,
                             completion: @escaping (Result<T>) -> Void
    ) {
        
        provider.request(MultiTarget(target)) { moyaResponse in
            switch moyaResponse {
            case .success(let response):
                switch response.response?.statusCode {
                case 401:
                    completion(.error(message: "unauthorized_error_message"))
                default:
                    completion(parser.parse(data: response.data))
                }
            case .failure(let error):
                switch error {
                case .underlying(let error, _):
                    if let error = (error as? AFError)?.underlyingError as NSError? {
                        if error.isConnectivityError == true {
                            completion(.error(message: "connectivity_error_message"))
                        } else {
                            completion(.error(message: "unknown_error_message"))
                        }
                    } else {
                        completion(.error(message: "unknown_error_message"))
                    }
                default:
                    completion(.error(message: "unknown_error_message"))
                }
            }
        }
    }
    
}
