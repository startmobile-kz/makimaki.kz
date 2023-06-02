//
//  DeliveryTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 01.06.2023.
//

import UIKit
import SnapKit

class DeliveryTableViewCell: UITableViewCell {
    
    //MARK: - UI
    
    private lazy var courierBackgroundImageView: UIImageView = {
        let image = UIImage(named: "courier_background.pdf")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var courierImageView: UIImageView = {
        let image = UIImage(named: "courier.pdf")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.40"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .blue
        return label
    }()

    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    
    //MARK: - Setup Constraints
    
    private func setupConstaints() {
        
    }

}
