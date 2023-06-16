//
//  RestaurantHeaderView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.06.2023.
//

import UIKit
import SnapKit

final class RestaurantHeaderView: UICollectionReusableView {
    
    static let reuseID = String(describing: RestaurantHeaderView.self)
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.restaurant_top_image.uiImage
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.bold.s28()
        label.textColor = AppColor.background.uiColor
        label.text = "Smile House Cafe"
        return label
    }()
    
    private lazy var ratingView: RestaurantInfoView = {
        let view = RestaurantInfoView(type: .ratingAndReview)
        return view
    }()
    
    private lazy var timeView: RestaurantInfoView = {
        let view = RestaurantInfoView(type: .time)
        return view
    }()
    
    private lazy var deliveryCostView: RestaurantInfoView = {
        let view = RestaurantInfoView(type: .deliveryCost)
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
        addSubviews([backgroundImageView, nameLabel,ratingView, timeView, deliveryCostView,categoryView])
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(-16)
            make.height.equalTo(254)
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
