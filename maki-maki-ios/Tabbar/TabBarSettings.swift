//
//  TabBarSettings.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 07.06.2023.
//

import Foundation
import UIKit

struct TabBarSettings {
    static let numberOfItems = 4
    static let tabBarItemImageWidth: CGFloat = 20
    static let tabBarItemImageHeight: CGFloat = 22
    static let ellipseHeight: CGFloat = 4
    static let ellipseWidth: CGFloat = 4
    static let tabBarItemHeight: CGFloat = tabBarItemImageHeight + ellipseHeight + 6
    static let tabBarHeight: CGFloat = 83
    static let spacingBetweenItems: CGFloat =
        (UIScreen.main.bounds.width - CGFloat(numberOfItems) * tabBarItemImageWidth) / CGFloat(numberOfItems)
}
