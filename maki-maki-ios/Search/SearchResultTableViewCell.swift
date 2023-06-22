//
//  SearchResultTableViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 06.06.2023.
//

import UIKit
import SnapKit

final class SearchResultTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: SearchResultTableViewCell.self)
    
    // MARK: - UI
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.cardImage_1.uiImage
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productNameLabel, priceLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var productNameLabel: UILabel = {
       let label = UILabel()
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
       let label = UILabel()
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
        contentView.addSubviews([productImageView, infoStackView])
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(16)
            make.bottom.equalTo(-8)
            make.size.equalTo(50)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.top.equalTo(11.5)
            make.bottom.equalTo(-11.5)
            make.trailing.equalTo(124)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
        }
    }
    
    public func setupData(dish: ProductModel) {
        productNameLabel.text = dish.name
        priceLabel.text = "\(dish.price) ₸"
        // let url = URL(string: dish.image ?? " ")
    }
    
}
