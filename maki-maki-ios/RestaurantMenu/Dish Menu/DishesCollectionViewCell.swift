//
//  DishesCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class DishesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Reusable Id for cell
    
    static let reuseID = String(describing: DishesCollectionViewCell.self)
    
    // MARK: - UI
    
    private lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.dish.uiImage
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Broiled Salmon Steak"
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.medium.s15()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var dishPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$8.40"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        label.textAlignment = .left
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var dishCountView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.accent.uiColor
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var dishCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.reqular.s14()
        return label
    }()
    
    private lazy var hrstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dishPriceLabel, dishCountView])
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
        contentView.addSubviews([dishImageView,dishNameLabel,hrstackView])
        dishCountView.addSubview(dishCountLabel)
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
        
        dishImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(145)
        }
        
        dishNameLabel.snp.makeConstraints { make in
            make.top.equalTo(dishImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        dishCountView.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        dishCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        hrstackView.snp.makeConstraints { make in
            make.top.equalTo(dishNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(dishNameLabel)
        }
    }
}
