//
//  SearchResultTableViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 06.06.2023.
//

import UIKit
import SnapKit

class SearchResultTableViewCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.cardImage_1.uiImage
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var productNameLabel: UILabel = {
        
       let label = UILabel()
        label.text = "Medium Supremo Pizza"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    private lazy var priceLabel: UILabel = {
        
       let label = UILabel()
        label.text = "14.40$"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.paragraph.uiColor
        return label
    }()
    
    // MARK: - Lifecycle
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
        let subviews = [productNameLabel, priceLabel]
        infoStackView.addSubviews(subviews)
        contentView.addSubview(productImageView)
        contentView.addSubview(infoStackView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.equalTo(16)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.top.equalTo(11.5)
            make.bottom.equalTo(-11.5)
            make.trailing.equalTo(124)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(productNameLabel.snp.bottom).offset(8)
        }
    }
}
