//
//  UIView+Extensions.swift
//  maki-maki-ios
//
//  Created by Shyngys on 31.05.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
     let cornerRadii = CGSize(width: radius, height: radius)
     let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
     let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
}
