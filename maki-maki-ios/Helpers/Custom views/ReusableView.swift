//
//  ReusableView.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 04.06.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

