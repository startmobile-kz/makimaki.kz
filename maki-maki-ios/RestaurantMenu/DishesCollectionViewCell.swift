//
//  DishesCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class DishesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Reusable Id for cell
    
    static let reuseID = String(describing: DishesCollectionViewCell.self)
    
    var counter: Int = 0
    
    // MARK: - UI
    
    private lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.dish.uiImage
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Broiled Salmon Steak"
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.medium.s15()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dishPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$8.40"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dishCountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3", for: .normal)
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.titleLabel?.font = AppFont.reqular.s14()
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(counterBtnDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var hrstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dishPriceLabel, dishCountButton])
        stackView.axis = .horizontal
        stackView.spacing = 77
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = AppColor.background.uiColor
        setupViews()
        setupConstraints()
        setupShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.layer.cornerRadius = 14
        [dishImageView, dishNameLabel, hrstackView].forEach {
            contentView.addSubview($0)
        }
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
        }
        
        dishNameLabel.snp.makeConstraints { make in
            make.top.equalTo(dishImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        hrstackView.snp.makeConstraints { make in
            make.top.equalTo(dishNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(dishNameLabel)
        }
    }
    
    // MARK: - Actions
    
    @objc private func counterBtnDidPressed() {
        counter += 1
        dishCountButton.setTitle("\(counter)", for: .normal)
    }
}
