//
//  AppImage.swift
//  maki-maki-ios
//
//  Created by Shyngys on 31.05.2023.
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
    case chevron_down = "chevron.down"
    case house = "house"
    case house_fill = "house.fill"
    case check = "check"
    case eye = "eye"
    case home = "home"
    case search = "search"
    case shopping_bag = "shopping_bag"
    case user = "user"
    case ellipse = "ellipse"
    case coupon = "coupon"
    case coupon_black = "coupon_black"
    case edit_avatar = "edit_avatar"
    case edit = "edit"
    case like = "like_al"
    case location = "location_al"
    case offer = "offer_al"
    case orders = "orders_al"
    case payment = "payment_al"
    case user_al = "user_al"
    case arrowRight = "arrow_right"
    case homeMA = "home_ma"
    case locationMA = "location_ma"
    case workMA = "work_ma"
    case arrow_down = "arrow_down"
    case arrow_up = "arrow_up"
    case divider = "divider"
    case home_selected = "home_selected"
    case search_selected = "search_selected"
    case shopping_bag_selected = "shopping_bag_selected"
    case user_selected = "user_selected"
    case welcomeImg = "welcomeImg"
    case no_orders = "no_orders"
    case cardImage_1 = "cardImage_1"
    case search_icon = "search_icon"
    case clear_icon = "clear_icon"
    case clock = "clock"
    case pizza_image = "pizza_image"
    case add_button = "add_button"
    case payments_card = "payments_card"
    case apple_pay = "apple_pay"
    case checked_button = "checked_button"
    case unchecked_button = "unchecked_button"
    case restaurant_top_image = "restaurant_top_image"
    case search_white = "search_white"
    case search_black = "search_black"
    case star = "star"
    case like_white = "like_white"
    case like_black = "like_black"
    case arrow_left_white = "arrow_left_white"
    case placeholder = "placeholder"
    case promo_1 = "promo_1"
    case like_fill = "like_fill"
    case like_red = "like_red"
}
