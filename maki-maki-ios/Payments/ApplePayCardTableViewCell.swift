//
//  AddNewCardTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 13.06.2023.
//

import UIKit

final class ApplePayCardTableViewCell: UITableViewCell {

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
//
//    private lazy var addButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = AppColor.grey100.uiColor
//        button.layer.cornerRadius = 12
//        return button
//    }()
    
//    private lazy var addButtonImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = AppImage.add_button.uiImage
//        return imageView
//    }()
    
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
        [cardImageView, addNewCardLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        cardImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        addNewCardLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cardImageView.snp.trailing).offset(16)
        }
        
//        addButton.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-16)
//            make.size.equalTo(40)
//        }
//        
//        addButtonImageView.snp.makeConstraints { make in
//            make.center.equalTo(addButton.snp.center)
//        }
        
    }
}
