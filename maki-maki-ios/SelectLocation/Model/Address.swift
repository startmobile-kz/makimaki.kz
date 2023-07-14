//
//  Address.swift
//  maki-maki-ios
//
//  Created by Tami on 06.07.2023.
//

import Foundation
import UIKit

struct Address: Codable {
    var id: UUID
    var street: String
    var latitude: Double
    var longitude: Double
    var house: String
    var flat: String
    var type: Int
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, street, latitude, longitude, house, flat, type
    }
}
