//
//  RestaurantCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 01.06.2023.
//

import UIKit
import SnapKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "RestaurantCell"
    
    //MARK: -UI
    private lazy var restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Restaurant1")
        
        return imageView
    }()
    
    private lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Taqueria Los Coyotes"
        label.font = AppFont.semibold.s18()
        
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
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let subviews = [restaurantImageView, restaurantNameLabel, starImageView, infoStackView]
        subviews.forEach( { contentView.addSubview($0) } )
        
        infoStackView.addArrangedSubview(ratingLabel)
    }
    
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
    }
}

