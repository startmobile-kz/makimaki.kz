//
//  Parser.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 11.06.2023.
//

import Foundation

enum Result<T: Codable> {
    
    case success(data: T?)
    case error(message: String)
}

protocol Parsing {
    
    func parse<Model: Codable>(data: Data) -> Result<Model>
}

struct Response<T: Codable>: Codable {
    
    let status: Bool
    let message: String?
    let data: T?
}


struct Parser: Parsing {

    static let shared = Parser()
    
    func parse<Model: Codable>(data: Data) -> Result<Model> {
    
        do {
            let parsed = try JSONDecoder().decode(Response<Model>.self, from: data)
            if parsed.status {
                return .success(data: parsed.data)
            } else {
                return .error(message: parsed.message ?? "unknown_error_message")
            }
        } catch {
            return .error(message: "processing_data_error_message")
        }
    }
}
