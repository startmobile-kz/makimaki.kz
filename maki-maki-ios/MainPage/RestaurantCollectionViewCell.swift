//
//  RestaurantCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 01.06.2023.
//

import UIKit
import SnapKit

final class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: RestaurantCollectionViewCell.self)
    
    //MARK: - UI
    private lazy var restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "restaurant_1")
        return imageView
    }()
    
    private lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Taqueria Los Coyotes"
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.tintColor = AppColor.heading.uiColor
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5.0"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var firstDotSeparatorLabel: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.font = AppFont.reqular.s12()
        label.textColor = AppColor.grey300.uiColor
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "15-20 mins"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var secondDotSeparatorLabel: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.font = AppFont.reqular.s12()
        label.textColor = AppColor.grey300.uiColor
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$$"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    
    //MARK: - Lifecycle
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
        let subviews = [restaurantImageView, restaurantNameLabel, starImageView, infoStackView]
        subviews.forEach( { contentView.addSubview($0) } )
        
        let arrangedSubviews = [ratingLabel, firstDotSeparatorLabel, timeLabel, secondDotSeparatorLabel, priceLabel]
        arrangedSubviews.forEach( {infoStackView.addArrangedSubview($0)} )
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
    }
}

