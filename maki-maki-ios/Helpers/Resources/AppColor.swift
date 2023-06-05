//
//  AppColor.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 31.05.2023.
//

import UIKit

protocol AppColorProtocol {
    var rawValue: String { get }
}

extension AppColorProtocol {

    var uiColor: UIColor {
        guard let color = UIColor.init(named: rawValue) else {
            fatalError("Could not find color with name \(rawValue)")
        }
        return color
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

enum AppColor: String, AppColorProtocol {
    case red
    case blue
    case green
    case accent
    case border
    case heading
    case paragraph
    case background
    case grey100
    case grey200
    case grey300
    case darkGreen
    case darkOrange
}



