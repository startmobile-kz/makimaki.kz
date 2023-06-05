//
//  AppFont.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 31.05.2023.
//

import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {
    
    func s12() -> UIFont {
        return apply(size: 12)
    }
    
    func s14() -> UIFont {
        return apply(size: 14)
    }
    
    func s15() -> UIFont {
        return apply(size: 15)
    }
    
    func s18() -> UIFont {
        return apply(size: 18)
    }
    
    func s20() -> UIFont {
        return apply(size: 20)
    }
    
    func s22() -> UIFont {
        return apply(size: 22)
    }
    
    func s24() -> UIFont {
        return apply(size: 24)
    }
    
    func s28() -> UIFont {
        return apply(size: 28)
    }
    
    func s32() -> UIFont {
        return apply(size: 32)
    }
    
    func s40() -> UIFont {
        return apply(size: 40)
    }
    
    func s48() -> UIFont {
        return apply(size: 48)
    }
}

extension AppFontProtocol {

    private func apply(size value: CGFloat) -> UIFont {
        guard let font = UIFont.init(name: rawValue, size: value) else {
            fatalError("Could not find font with name \(rawValue)")
        }
        return font
    }
}

enum AppFont: String, AppFontProtocol {
    case reqular = "Inter-Regular"
    case medium = "Inter-Medium"
    case semibold = "Inter-SemiBold"
    case bold = "Inter-Bold"
}
