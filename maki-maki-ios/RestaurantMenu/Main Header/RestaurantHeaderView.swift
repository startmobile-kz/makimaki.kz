//
//  RestaurantHeaderView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class RestaurantHeaderView: UICollectionReusableView {
    
    static let reuseID = String(describing: RestaurantHeaderView.self)
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.restaurant_top_image.uiImage
//        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.arrow_left_white.uiImage, for: .normal)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.like_white.uiImage, for: .normal)
        button.isSkeletonable = true
        button.skeletonCornerRadius = 5
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.bold.s28()
        label.textColor = AppColor.background.uiColor
        label.text = "Smile House Cafe"
        label.isSkeletonable = true
        label.lastLineFillPercent = 242
        label.skeletonTextLineHeight = .relativeToFont
        label.linesCornerRadius = 14
        return label
    }()
    
    private lazy var ratingView: RestaurantInfoView = {
        let view = RestaurantInfoView(type: .ratingAndReview)
        view.isSkeletonable = true
        view.skeletonCornerRadius = 14
        return view
    }()
    
    private lazy var timeView: RestaurantInfoView = {
        let view = RestaurantInfoView(type: .time)
        view.isSkeletonable = true
        view.skeletonCornerRadius = 14
        return view
    }()
    
    private lazy var deliveryCostView: RestaurantInfoView = {
        let view = RestaurantInfoView(type: .deliveryCost)
        view.isSkeletonable = true
        view.skeletonCornerRadius = 14
        return view
    }()
    
    private lazy var categoryView: CategoryMenuView = {
        let view = CategoryMenuView()
        return view
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
        addSubviews(
            [backgroundImageView,
             backButton,
             likeButton,
             nameLabel,
             ratingView,
             timeView,
             deliveryCostView,categoryView
            ])
        isSkeletonable = true
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(-16)
            make.height.equalTo(254)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(57)
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(22)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(57)
            make.trailing.equalToSuperview().offset(-14)
            make.size.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(16)
        }
        
        timeView.snp.makeConstraints { make in
            make.centerY.equalTo(ratingView.snp.centerY)
            make.leading.equalTo(ratingView.snp.trailing).offset(8)
        }
        
        deliveryCostView.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
