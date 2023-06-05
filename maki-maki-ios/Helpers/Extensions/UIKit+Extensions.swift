//
//  UIKit+Extensions.swift
//  maki-maki-ios
//
//  Created by   Shyngys on 04.06.2023.
//

import UIKit

// MARK: - UIView
extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}

// MARK: - UITextField
extension UITextField {
    
   func addBottomBorder() {
       let bottomLine = CALayer()
       bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
       bottomLine.backgroundColor = AppColor.border.uiColor.cgColor
       borderStyle = .none
       layer.addSublayer(bottomLine)
   }
}

// MARK: - UITableView
extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

// MARK: - UICollectionView
extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
