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
        label.text = "SkeletonLabelLabel"
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.skeletonTextLineHeight = .relativeToFont
        return label
    }()
    
    private lazy var orderStatusView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.skeletonCornerRadius = 8
        return view
    }()
    
    private lazy var orderDataLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.paragraph.uiColor
        label.text = "31 May 2020, 07:55 PM • $43.95"
        label.linesCornerRadius = 8
        label.isSkeletonable = true
        return label
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
//        button.isSkeletonable = true
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
            orderStatusView,
            orderDataLabel,
            dividerImageView,
            collapseMenuButton
        ].forEach { contentView.addSubview($0) }
        
        isSkeletonable = true
        contentView.isSkeletonable = true
    }
    
    private func setupLayout() {
        cafeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(22)
        }
        
        orderStatusView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(29)
            make.width.equalTo(83)
        }
        
        orderDataLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(17)
        }
        
        dividerImageView.snp.makeConstraints { make in
            make.top.equalTo(orderDataLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
//            make.centerX.equalToSuperview()
        }
        
        collapseMenuButton.snp.makeConstraints { make in
            make.top.equalTo(orderDataLabel.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}
