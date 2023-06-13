//
//  DishViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 13.06.2023.
//

import UIKit
import SnapKit

final class DishViewController: UIViewController {
    
    // MARK: - UI

    private lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.pizza_image.uiImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubview(dishImageView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        dishImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-30)
        }
        
    }
}
