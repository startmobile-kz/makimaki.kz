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
    
    private lazy var ratingView: RestaurantInfoView = {
        let view = RestaurantInfoView(type: .ratingAndReview)
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
        addSubviews([backgroundImageView, ratingView])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(-16)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(16)
        }
    }
}
