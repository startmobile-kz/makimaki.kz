//
//  RatingView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.06.2023.
//

import UIKit
import SnapKit

final class RatingReviewsView: UIView {
    
    // MARK: - UI
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.star.uiImage
        return imageView
    }()
    
    private lazy var ratingReviewsLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.text = "4.8"
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
    
    // MARK: - SetupViews
    private func setupViews() {
        backgroundColor = AppColor.grey100.uiColor
        layer.cornerRadius = 14
        ratingReviewsLabel.attributedText = makeAttributedString(rating: 4.8, reviews: 420)
        addSubviews([starImageView, ratingReviewsLabel])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        starImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15.5)
        }
        
        ratingReviewsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(starImageView.snp.trailing).offset(5.5)
        }
    }
    
    private func makeAttributedString(rating: Float, reviews: Int) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.reqular.s14(),
            .foregroundColor: AppColor.heading.uiColor
        ]
        
        let rootString = NSMutableAttributedString(string: String(rating), attributes: attributes)
        let dotString = NSAttributedString(string: "  •  ", attributes: attributes)
        let reviewsString = NSAttributedString(string: "\(reviews) Reviews")
        rootString.append(dotString)
        rootString.append(reviewsString)
        return rootString
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 174, height: 40)
    }
}
