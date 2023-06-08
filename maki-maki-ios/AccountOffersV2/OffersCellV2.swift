//
//  OffersCellV2.swift
//  maki-maki-ios
//
//  Created by Ravil on 07.06.2023.
//

import UIKit
import SnapKit

final class OffersCellV2: UITableViewCell {

    // MARK: - UI
    
    private lazy var couponImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.coupon_black.uiImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var saleOffLabel: UILabel = {
        let label = UILabel()
        label.text = "Sale off 30%"
        label.font = AppFont.semibold.s18()
        return label
    }()
    
    private lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.text = "7 Days Left"
        label.font = AppFont.reqular.s15()
        return label
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("COPY", for: .normal)
        button.backgroundColor = AppColor.accent.uiColor
        button.tintColor = AppColor.heading.uiColor
        button.layer.cornerRadius = 8
        return button
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
        contentView.addSubview(couponImage)
        contentView.addSubview(saleOffLabel)
        contentView.addSubview(daysLabel)
        contentView.addSubview(copyButton)
    }

    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        couponImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-20)
        }
        saleOffLabel.snp.makeConstraints { make in
            make.top.equalTo(19)
            make.leading.equalTo(couponImage.snp.trailing).offset(13)
        }
        daysLabel.snp.makeConstraints { make in
            make.top.equalTo(saleOffLabel.snp.bottom).offset(4)
            make.leading.equalTo(couponImage.snp.trailing).offset(13)
        }
        copyButton.snp.makeConstraints { make in
            make.top.equalTo(19)
            make.leading.equalToSuperview().offset(261)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
}
