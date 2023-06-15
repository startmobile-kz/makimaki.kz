//
//  AddNewCardTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 13.06.2023.
//

import UIKit

final class ApplePayCardTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.apple_pay.uiImage
        return imageView
    }()
    
    private lazy var addNewCardLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple Pay"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    // MARK: - Lifecyсle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = AppColor.border.cgColor
        containerView.layer.borderWidth = 1
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [cardImageView, addNewCardLabel].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        cardImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        addNewCardLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cardImageView.snp.trailing).offset(16)
        }
    }
}
