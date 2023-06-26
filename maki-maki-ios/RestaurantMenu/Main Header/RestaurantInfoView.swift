//
//  RatingView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.06.2023.
//

import UIKit
import SnapKit

final class RestaurantInfoView: UIView {
    
    // MARK: - State
    
    private let type: RestaurantsCharacteristic
    
    // MARK: - UI
    
    private lazy var starImageView: UIImageView? = {
        let imageView = UIImageView()
//        imageView.image = AppImage.star.uiImage
        return imageView
    }()
    
    private lazy var characteristicLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    // MARK: - Lifecycle
    
    init(type: RestaurantsCharacteristic) {
        self.type = type
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        makeAdaptiveSizeForView()
    }
    
    private func makeAdaptiveSizeForView() {
        let spacingBetweenImageViewAndLabel: CGFloat = 5.5
        let leadingAndTrailingOffsets: CGFloat = 14 * 2
        let offsetsPlusLabelWidth: CGFloat = characteristicLabel.frame.width + leadingAndTrailingOffsets
        
        switch type {
        case .ratingAndReview:
            guard let starImageView = starImageView else {
                return
            }
            snp.makeConstraints { make in
                make.width.equalTo(
                    offsetsPlusLabelWidth + starImageView.frame.width + spacingBetweenImageViewAndLabel
                )
            }
        case .time, .deliveryCost:
            snp.makeConstraints { make in
                make.width.equalTo(offsetsPlusLabelWidth)
            }
        }
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 14
        
        switch type {
        case .ratingAndReview:
            addSubviews([starImageView ?? UIImageView(), characteristicLabel])
            characteristicLabel.attributedText = makeAttributedStringForRating(rating: 4.8, reviews: 420)
        case .time:
            addSubview(characteristicLabel)
            characteristicLabel.text = "15-20 mins"
            starImageView = nil
        case .deliveryCost:
            addSubview(characteristicLabel)
            characteristicLabel.text = "Delivery - $8.99"
            starImageView = nil
        }
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        if let starImageView = starImageView {
            starImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(15.5)
            }
            
            characteristicLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(starImageView.snp.trailing).offset(5.5)
            }
        } else {
            characteristicLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
    
    private func makeAttributedStringForRating(rating: Float, reviews: Int) -> NSMutableAttributedString {
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
