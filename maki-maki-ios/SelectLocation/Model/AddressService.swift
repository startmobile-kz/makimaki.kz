//
//  AddressService.swift
//  maki-maki-ios
//
//  Created by Tami on 06.07.2023.
//

import Foundation

class AddressService {
    
    private let addressesKey = "addressKey"
    
    func saveAddress(address: Address) {
        var savedAddresses = fetchAddresses()
        savedAddresses.append(address)
        
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(savedAddresses) {
            UserDefaults.standard.set(encodedData, forKey: addressesKey)
        }
    }
    
    func deleteAddress(address: Address) {
        var savedAddresses = fetchAddresses()
        if let index = savedAddresses.firstIndex(where: {$0.id == address.id}) {
            savedAddresses.remove(at: index)
        }
        
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(savedAddresses) {
            UserDefaults.standard.set(encodedData, forKey: addressesKey)
        }
    }
    
    func fetchAddresses() -> [Address] {
        if let savedData = UserDefaults.standard.data(forKey: addressesKey) {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Address].self, from: savedData) {
                return decodedData
            }
        }
        return []
    }
    
    func updateAddress(address: Address) {
        var savedAddresses = fetchAddresses()
        if let index = savedAddresses.firstIndex(where: {$0.id == address.id}) {
            savedAddresses[index] = address
        }
        
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(savedAddresses) {
            UserDefaults.standard.set(encodedData, forKey: addressesKey)
        }
    }
}
