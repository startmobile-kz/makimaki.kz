//
//  KeyManager.swift
//  maki-maki-ios
//
//  Created by Darkhan on 10.07.2023.
//

import Foundation
import Security

enum KeychainError: Error {
    case duplicateItem
    case unknown(status: OSStatus)
    case itemNotFound
}

final class KeychainManager {
    static func saveCreditCardInfo(cardNumber: String, cvv: String,
                                   cardHolderName: String, expirationDate: String,
                                   account: String) throws -> String {
        let creditCardData = """
            Card Number: \(cardNumber)
            CVV: \(cvv)
            Card Holder Name: \(cardHolderName)
            Expiration Date: \(expirationDate)
            """.data(using: .utf8)!
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: creditCardData,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }
        
        return "Saved"
    }
    
    static func retrieveCreditCardInfo(account: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess, let data = result as? Data else {
            throw KeychainError.unknown(status: status)
        }
        
        if let creditCardInfo = String(data: data, encoding: .utf8) {
            return creditCardInfo
        } else {
            throw KeychainError.unknown(status: errSecDecode)
        }
    }
    
    static func updateCreditCardInfo(cardNumber: String, cvv: String,
                                     cardHolderName: String, expirationDate: String,
                                     account: String) throws -> String {
        let creditCardData = """
            Card Number: \(cardNumber)
            CVV: \(cvv)
            Card Holder Name: \(cardHolderName)
            Expiration Date: \(expirationDate)
            """.data(using: .utf8)!
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account
        ]
        
        let attributes: [CFString: Any] = [
            kSecValueData: creditCardData
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }
        
        return "Updated"
    }
    
    static func deleteCreditCardInfo(account: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }
        
        return "Deleted"
    }
}
