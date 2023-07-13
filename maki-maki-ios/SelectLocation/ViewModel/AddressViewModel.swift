//
//  AddressViewModel.swift
//  maki-maki-ios
//
//  Created by Tami on 13.07.2023.
//

import Foundation

class AddressViewModel {
    
    private let service = AddressService()
    
    var addresses: [Address] = [] {
        didSet {
            reloadDataCallback?()
        }
    }
    
    var reloadDataCallback: (() -> Void)?
    
    func saveAddress(with address: Address) {
        let newAddress = Address(id: UUID(),
                                 street: address.street,
                                 latitude: address.latitude,
                                 longitude: address.longitude,
                                 house: address.house,
                                 flat: address.flat,
                                 type: address.type)
        service.saveAddress(address: newAddress)
    }
    
    func fetchAdresses() {
        addresses = service.fetchAddresses()
    }
    
    func deleteAddress(index: IndexPath) {
        let address = addresses[index.row]
        service.deleteAddress(address: address)
        addresses.remove(at: index.row)
    }
}
