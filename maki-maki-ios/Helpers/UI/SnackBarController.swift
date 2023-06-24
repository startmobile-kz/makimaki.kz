//
//  SnackBarController.swift
//  maki-maki-ios
//
//  Created by Islam Temirbek on 24.06.2023.
//

import UIKit
import SnackBar_swift

final class SnackBarController: SnackBar {

    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = AppColor.accent.uiColor
        style.textColor = AppColor.heading.uiColor
        return style
    }

    static func showSnackBar(in view: UIView, message: String, duration: Duration) {
        let snackBar = SnackBarController.make(in: view, message: message, duration: duration)
        snackBar.show()
    }

}
