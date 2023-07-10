//
//  DeliveryFooterView.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 01.06.2023.
//

import UIKit
import SnapKit

class DeliveryFooterView: UITableViewHeaderFooterView {
    private lazy var courierBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "courier_background")
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var courierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "courier")
        return imageView
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "FREE"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.paragraph.uiColor
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(courierBackgroundImageView)
        addSubview(courierImageView)
        addSubview(deliveryLabel)
        addSubview(deliveryPriceLabel)
    }
    
    private func setupConstraints() {
        courierBackgroundImageView.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        courierImageView.snp.makeConstraints { make in
            make.center.equalTo(courierBackgroundImageView.snp.center)
        }
        
        deliveryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(courierBackgroundImageView.snp.trailing).offset(16)
        }
        
        deliveryPriceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
