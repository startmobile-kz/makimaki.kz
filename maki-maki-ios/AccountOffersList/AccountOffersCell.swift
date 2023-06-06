//
//  AccountOffersCell.swift
//  maki-maki-ios
//
//  Created by Ravil on 06.06.2023.
//

import UIKit
import SnapKit

final class AccountOffersCell: UITableViewCell {

    // MARK: - UI
    
    private lazy var couponImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coupon.pdf")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "30\n%"
        label.numberOfLines = 0
        label.font = AppFont.bold.s40()
        return label
    }()
    
    private lazy var saleOffLabel: UILabel = {
        let label = UILabel()
        label.text = "Sale OFF"
        label.font = AppFont.bold.s24()
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
        button.backgroundColor = AppColor.heading.uiColor
        button.tintColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(saleOffLabel)
        contentView.addSubview(daysLabel)
        contentView.addSubview(copyButton)
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        couponImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(124)
            make.top.equalTo(122)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(couponImage.snp.leading).offset(24)
            make.centerY.equalTo(couponImage.snp.centerY)
        }
        saleOffLabel.snp.makeConstraints { make in
            make.leading.equalTo(couponImage.snp.leading).offset(138)
            make.centerY.equalTo(couponImage.snp.centerY)
        }
        daysLabel.snp.makeConstraints { make in
            make.leading.equalTo(couponImage.snp.leading).offset(138)
            make.centerY.equalTo(saleOffLabel.snp.bottom).offset(8)
        }
        copyButton.snp.makeConstraints { make in
            make.leading.equalTo(couponImage.snp.leading).offset(255)
            make.centerY.equalTo(couponImage.snp.centerY)
            make.width.height.equalTo(64)
        }
    }
}
