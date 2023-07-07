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
    var type: String
}

enum LocationType: String {
    case home
    case work
    case other
}
