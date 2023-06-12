//
//  PaymentsTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 12.06.2023.
//

import UIKit

final class PaymentsTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.payments_card.uiImage
        return imageView
    }()
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Credit Card"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.grey100.uiColor
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var editButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.edit.uiImage
        return imageView
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
        [cardImageView, cardNameLabel, editButton, editButtonImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        cardImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        cardNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cardImageView.snp.trailing).offset(16)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(40)
        }
        
        editButtonImageView.snp.makeConstraints { make in
            make.center.equalTo(editButton.snp.center)
        }
        
    }
}