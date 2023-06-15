//
//  RatingView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.06.2023.
//

import UIKit
import SnapKit

class RatingView: UIView {
    
    // MARK: - UI
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.star.uiImage
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.text = "4.8"
        return label
    }()
    
    private lazy var ratingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starImageView, ratingLabel])
        stack.axis = .vertical
        stack.spacing = 5.5
        return stack
    }()
    
    private lazy var dotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.ellipse.uiImage
        return imageView
    }()
    
    private lazy var reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.text = "500 Reviews"
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingStack, dotImageView, reviewsLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        addSubviews([mainStack])
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
