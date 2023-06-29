//
//  DishesCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView

final class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - State
    
    static let reuseID = String(describing: ProductCollectionViewCell.self)
    
    // MARK: - UI
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.medium.s15()
        label.textAlignment = .left
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        label.textAlignment = .left
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var productCountView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.accent.uiColor
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var productCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.reqular.s14()
        return label
    }()
    
    private lazy var hrstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productPriceLabel, productCountView])
        stackView.axis = .horizontal
        stackView.spacing = 77
        stackView.distribution = .equalSpacing
        stackView.isSkeletonable = true
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        isSkeletonable = true
        contentView.backgroundColor = AppColor.background.uiColor
        contentView.layer.cornerRadius = 14
        contentView.addSubviews([productImageView,productNameLabel,hrstackView])
        productCountView.addSubview(productCountLabel)
    }
    
    // MARK: - Setup Shadows
    
    private func setupShadows() {
        let cornerRadius: CGFloat = 14.0
        layer.shadowColor = AppColor.grey300.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        layer.shadowRadius = 7.0
        
        let cgPath = UIBezierPath(roundedRect: bounds,
                                  byRoundingCorners: [.allCorners],
                                  cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shadowPath = cgPath
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(145)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        productCountView.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        productCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        hrstackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(productNameLabel)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    // swiftlint:disable all
    
    public func setupData(product: RestaurantProduct) {
        productNameLabel.text = product.name
        productPriceLabel.text = "\(product.price) ₸"
        productCountView.isHidden = product.count == 0
        productCountLabel.text = "\(product.count)"
        
        let urlString = (product.image ?? " ").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? " "
        let url = URL(string: urlString)
        productImageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 149, height: 145))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
    // swiftlint:enable all
