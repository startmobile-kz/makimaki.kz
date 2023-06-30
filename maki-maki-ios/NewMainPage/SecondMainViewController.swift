//
//  SecondMainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 30.06.2023.
//

import UIKit
import SnapKit

class SecondMainViewController: UIViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - SetupView
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
    }
    
    // MARK: - SetupLayout
    
    private func setupConstraints() {
        
    }
}
