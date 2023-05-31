//
//  UIView+Extensions.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 31.05.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ view: [UIView]) {
        subviews.forEach { view in
            addSubview(view)
        }
    }
}
