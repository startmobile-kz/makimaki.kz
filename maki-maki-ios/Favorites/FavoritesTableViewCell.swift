//
//  FavoritesTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 07.06.2023.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var favoritesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "orderImage")
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private lazy var favoritesNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bellissimo Pizza"
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var favoritesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Pizza, Sushi, Burgers, Salads, Desserts"
        label.numberOfLines = 0
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.paragraph.uiColor
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.8"
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
    
    private lazy var deliveryTimeLabel: UILabel = {
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
    
    // MARK: - Lifecyle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [favoritesImageView, favoritesNameLabel, favoritesDescriptionLabel, starImageView, ratingLabel,
         firstDotSeparatorLabel, deliveryTimeLabel, secondDotSeparatorLabel, priceLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints

    private func setupConstraints() {
        favoritesImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(90)
            
        }
        
        favoritesNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(favoritesImageView.snp.trailing).offset(16)
        }
        
        favoritesDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(favoritesNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(favoritesImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        starImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-22)
            make.leading.equalTo(favoritesImageView.snp.trailing).offset(16)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(starImageView.snp.trailing).offset(5.5)
        }
        
        firstDotSeparatorLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(8)
        }
        
        deliveryTimeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(firstDotSeparatorLabel.snp.trailing).offset(8)
        }
        
        secondDotSeparatorLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(deliveryTimeLabel.snp.trailing).offset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(secondDotSeparatorLabel.snp.trailing).offset(8)
        }
        
    }

}
