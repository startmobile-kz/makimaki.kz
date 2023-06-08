//
//  AppImage.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 31.05.2023.
//

import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
}

enum AppImage: String, AppImageProtocol {
    case burger
    case chevronDown = "chevron.down"
    case house = "house"
    case house_fill = "house.fill"
    case check = "check"
    case eye = "eye"
    case coupon = "coupon"
    case edit_avatar = "edit_avatar"
    case edit = "edit"
    case like = "like_al"
    case location = "location_al"
    case offer = "offer_al"
    case orders = "orders_al"
    case payment = "payment_al"
    case user = "user_al"
    case arrowRight = "arrow_right"
    case homeMA = "home_ma"
    case locationMA = "location_ma"
    case workMA = "work_ma"
    case welcomeImg = "welcomeImg"
}
