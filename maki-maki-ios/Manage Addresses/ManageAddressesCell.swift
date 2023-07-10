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
    
    private lazy var imageAddressView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
   
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
    
    public func set(address: Address) {
        
        addressLabel.text = address.street
        
        if address.type == 0 {
            imageAddressView.image = AppImage.homeMA.uiImage
            return nameLabel.text = "Home"
        } else if address.type == 1 {
            imageAddressView.image = AppImage.workMA.uiImage
            return nameLabel.text = "Work"
        } else if address.type == 2 {
            imageAddressView.image = AppImage.locationMA.uiImage
            return nameLabel.text = "Other"
        }
        
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubview(imageAddressView)
        addSubview(nameLabel)
        addSubview(addressLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        imageAddressView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.leading.equalToSuperview().offset(16)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageAddressView.snp.trailing).offset(14)
        }

        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(imageAddressView.snp.trailing).offset(14)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
