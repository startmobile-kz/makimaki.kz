//
//  ManageAdressesCell.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import UIKit
import SnapKit

class ManageAdressesCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var imageAdress = UIImageView()
   
    private lazy var nameLable: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.adjustsFontSizeToFitWidth = true
         label.font = AppFont.medium.s15()
         label.textColor = AppColor.heading.uiColor
         return label
    }()
    
    private lazy var addressLable: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.adjustsFontSizeToFitWidth = true
         label.font = AppFont.reqular.s15()
         label.textColor = AppColor.paragraph.uiColor
         return label
    }()

    // MARK: - Lifecyclu
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        constraintsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(address: Adress) {
        imageAdress.image = address.imageAdress.uiImage
        nameLable.text = address.nameLable
        addressLable.text = address.addressLable
    }
    
    // MARK: - Set UI
    func setUI() {
        addSubview(imageAdress)
        addSubview(nameLable)
        addSubview(addressLable)
    }
    
    // MARK: - Constraints
    func constraintsUI() {
        imageAdress.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        nameLable.snp.makeConstraints { make in
            make.top.equalTo(imageAdress.snp.top)
            make.leading.equalTo(imageAdress.snp.trailing).offset(14)
        }

        addressLable.snp.makeConstraints { make in
            make.top.equalTo(nameLable.snp.bottom).offset(8)
            make.leading.equalTo(imageAdress.snp.trailing).offset(14)
        }
    }
}
