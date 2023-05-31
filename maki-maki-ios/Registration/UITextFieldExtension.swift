//
//  UITextFieldExtension.swift
//  maki-maki-ios
//
//  Created by Tami on 31.05.2023.
//

import Foundation
import UIKit

// MARK: - Extension for border bottom line
extension UITextField {
   func addBottomBorder(){
       let bottomLine = CALayer()
       bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
       bottomLine.backgroundColor = AppColor.border.uiColor.cgColor
       borderStyle = .none
       layer.addSublayer(bottomLine)
   }
}
