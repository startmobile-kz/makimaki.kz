//
//  BasketTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 01.06.2023.
//

import UIKit
import SnapKit

final class BasketTableViewCell: UITableViewCell {
    // MARK: - UI
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "orderImage")
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var quantiiyLabel: UILabel = {
        let label = UILabel()
        label.text = "1  x"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pesto Tomato Pizza"
        label.numberOfLines = 0
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        label.sizeToFit()
        return label
    }()
    
    private lazy var priceOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "$10.95"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.paragraph.uiColor
        return label
    }()
    
    // MARK: - LifeCycle
    
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
        contentView.addSubview(productImageView)
        contentView.addSubview(quantiiyLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceOrderLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        quantiiyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(quantiiyLabel.snp.trailing).offset(10)
            make.width.equalTo(101)
        }
        
        priceOrderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
