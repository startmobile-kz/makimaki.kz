//
//  Adress.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import UIKit

struct Adress {
    var image: AppImage
    var title: String
    var subTitle: String
}

struct Address: Codable {
    var id: UUID
    var street: String
    var latitude: Double
    var longitude: Double
    var house: String
    var flat: String
    var type: Int
}

enum LocationType: String {
    case home
    case work
    case other
    
    var image: UIImage {
        switch self {
        case .home:
            return AppImage.homeMA.uiImage!
        case .work:
            return AppImage.workMA.uiImage!
        case .other:
            return AppImage.locationMA.uiImage!
        }
    }
    
    var description: String {
        switch self {
        case .home:
            return "Home"
        case .work:
            return "Work"
        case .other:
            return "Other"
        }
    }
}
