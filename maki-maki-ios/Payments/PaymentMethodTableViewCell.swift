//
//  PaymentMethodTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 15.06.2023.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    
    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.payments_card.uiImage
        return imageView
    }()
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Credit Card **7747"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
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

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = AppColor.border.cgColor
        containerView.layer.borderWidth = 1
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [cardImageView, cardNameLabel, checkButton].forEach {
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
        
        cardNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cardImageView.snp.trailing).offset(16)
        }
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(20)
        }
    }
    
    func didSelect(value: Bool) {
        if value {
            checkButton.backgroundColor = .yellow
        } else {
            checkButton.backgroundColor = .red
        }
    }
}
