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
       bottomLine.backgroundColor = UIColor(red: 224/256, green: 224/256, blue: 224/256, alpha: 1).cgColor
       borderStyle = .none
       layer.addSublayer(bottomLine)
   }
}
