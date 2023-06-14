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
        imageView.image = UIImage(named: "promo_1")
        return imageView
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView()
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
        backgroundColor = .cyan
        addSubviews([backgroundImageView, ratingView])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(16)
        }
    }
}
