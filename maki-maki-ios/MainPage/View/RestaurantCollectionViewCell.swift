//
//  RestaurantCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 01.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: RestaurantCollectionViewCell.self)
    
    // MARK: - UI
    private lazy var restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "restaurant_1")
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Taqueria Los Coyotes"
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.heading.uiColor
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.tintColor = AppColor.heading.uiColor
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.isSkeletonable = true
        return stack
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5.0"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var firstDotSeparatorLabel: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.font = AppFont.reqular.s12()
        label.textColor = AppColor.grey300.uiColor
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "15-20 mins"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var secondDotSeparatorLabel: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.font = AppFont.reqular.s12()
        label.textColor = AppColor.grey300.uiColor
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$$"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var restaurantDeliveryTypeView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 16
        uiView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        uiView.backgroundColor = AppColor.accent.uiColor
        uiView.isSkeletonable = true
        return uiView
    }()
    
    private lazy var deliveryTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery Type"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.isSkeletonable = true
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
        contentView.isSkeletonable = true
        isSkeletonable = true
        restaurantImageView.addSubview(restaurantDeliveryTypeView)
        restaurantDeliveryTypeView.addSubview(deliveryTypeLabel)
        let subviews = [restaurantImageView, restaurantNameLabel, starImageView, infoStackView]
        subviews.forEach({contentView.addSubview($0)})
        let arrangedSubviews = [
            ratingLabel,
            firstDotSeparatorLabel,
            timeLabel,
            secondDotSeparatorLabel,
            priceLabel
        ]
        arrangedSubviews.forEach({infoStackView.addArrangedSubview($0)})
        hideSkeleton()
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        restaurantImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        restaurantNameLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantImageView.snp.bottom).offset(11)
            make.leading.equalTo(restaurantImageView.snp.leading)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(restaurantNameLabel.snp.bottom).offset(9)
            make.leading.equalTo(restaurantNameLabel.snp.leading)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView.snp.centerY)
            make.leading.equalTo(starImageView.snp.trailing).offset(5.5)
        }
        
        firstDotSeparatorLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(7)
        }
        
        restaurantDeliveryTypeView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(223)
            make.height.equalTo(41)
        }
        
        deliveryTypeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
