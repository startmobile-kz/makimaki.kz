//
//  OrdersSkeletonCell.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.07.2023.
//

import UIKit
import SnapKit
import SkeletonView

class OrdersSkeletonCell: UITableViewCell {
    
    static let reuseID = String(describing: OrdersSkeletonCell.self)
    
    // MARK: - UI
    
    private lazy var cafeNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderStatusLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 6
        return label
    }()
    
    private lazy var orderDataLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.paragraph.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderPriceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dataPriceLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var dividerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.divider.uiImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var collapseMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.arrow_down.uiImage, for: .normal)
        button.backgroundColor = AppColor.background.uiColor
        button.tintColor = AppColor.heading.uiColor
        button.layer.borderWidth = 0.4
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = AppColor.background.uiColor
        
        [
            cafeNameLabel,
            orderStatusLabel,
            dataPriceLabelsStackView,
            dividerImageView,
            collapseMenuButton
        ].forEach { addSubview($0) }
        
        [
            orderDataLabel,
            orderPriceLabel
        ].forEach { dataPriceLabelsStackView.addArrangedSubview($0) }
    }
    
    private func setupLayout() {
        cafeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(22)
        }
        
        orderStatusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(29)
            make.width.equalTo(83)
        }
        
        dataPriceLabelsStackView.snp.makeConstraints { make in
            make.top.equalTo(cafeNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(17)
        }
        
        dividerImageView.snp.makeConstraints { make in
            make.top.equalTo(dataPriceLabelsStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
        
        collapseMenuButton.snp.makeConstraints { make in
            make.top.equalTo(dataPriceLabelsStackView.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }
}
