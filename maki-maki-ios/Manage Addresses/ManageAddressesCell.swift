//
//  ManageAdressesCell.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import UIKit
import SnapKit

final class ManageAddressesCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var imageAddressView = UIImageView()
   
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.adjustsFontSizeToFitWidth = true
         label.font = AppFont.medium.s15()
         label.textColor = AppColor.heading.uiColor
         return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.adjustsFontSizeToFitWidth = true
         label.font = AppFont.reqular.s15()
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
    
    func set(address: Adress) {
        imageAddressView.image = address.image.uiImage
        nameLabel.text = address.title
        addressLabel.text = address.subTitle
    }
    
    // MARK: - Setup Views
    func setupViews() {
        addSubview(imageAddressView)
        addSubview(nameLabel)
        addSubview(addressLabel)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        imageAddressView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageAddressView.snp.top)
            make.leading.equalTo(imageAddressView.snp.trailing).offset(14)
        }

        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(imageAddressView.snp.trailing).offset(14)
        }
    }
}
