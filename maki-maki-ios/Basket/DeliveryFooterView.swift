//
//  DeliveryFooterView.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 01.06.2023.
//

import UIKit
import SnapKit

final class DeliveryFooterView: UITableViewHeaderFooterView {

    public static let reuseIdentifier = String(describing: DeliveryFooterView.self)

    // MARK: - UI
    
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
        label.text = "500"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.paragraph.uiColor
        return label
    }()

    // MARK: - LifeCycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstaints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(courierBackgroundImageView)
        contentView.addSubview(courierImageView)
        contentView.addSubview(deliveryLabel)
        contentView.addSubview(deliveryPriceLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstaints() {
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
