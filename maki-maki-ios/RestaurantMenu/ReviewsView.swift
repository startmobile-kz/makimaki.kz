//
//  ReviewsView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 08.06.2023.
//

import UIKit
import SnapKit

class ReviewsView: UIView {
    
    // MARK: - UI
    lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.star.uiImage
        return imageView
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.8 • 415 Reviews"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        return label
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
    
    private func setupViews() {
        addSubviews([starImageView, ratingLabel])
    }
    
    private func setupConstraints() {
        starImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(15.5)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(starImageView.snp.trailing).offset(5.5)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 174, height: 40)
    }
}
