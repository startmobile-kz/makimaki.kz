//
//  StorageManager.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 12.06.2023.
//

import Foundation

class StorageManager {
    
    private let storage = UserDefaults.standard
    
    static let shared: StorageManager = StorageManager()
    
    private init() {}
}

extension StorageManager {
    
//    func getToken() -> TokenModel? {
//
//        if let token = storage.retrieve(object: TokenModel.self, fromKey: Key.Storage.token) {
//            return token
//        }
//
//        return nil
//    }
//
//    func setToken(with token: TokenModel?) -> Void {
//
//        storage.save(customObject: token, inKey: Key.Storage.token)
//    }
}

