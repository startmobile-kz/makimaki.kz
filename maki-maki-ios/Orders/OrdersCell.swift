//
//  OrderViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 31.05.2023.
//

import UIKit
import SnapKit

final class OrdersCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var orderNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bellissimo Pizza"
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivered"
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        label.backgroundColor = AppColor.green.uiColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 6
        return label
    }()
    
    private lazy var orderDataLabel: UILabel = {
        let label = UILabel()
        let data = "31 May 2020, 07:55 PM  "
        let components = [
            NSAttributedString(string: NSLocalizedString(data, comment: "Data"), attributes: [
                .foregroundColor: AppColor.paragraph.uiColor,
                .font: AppFont.reqular.s14()
            ]),
            NSAttributedString(string: NSLocalizedString("•", comment: "Point"), attributes: [
                .foregroundColor: AppColor.grey300.uiColor,
                .font: AppFont.reqular.s15()
            ])
        ]
        let string = NSMutableAttributedString()
        components.forEach(string.append)
        label.attributedText = string
        label.font = AppFont.reqular.s14()
        label.textColor = AppColor.paragraph.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
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
        imageView.image = #imageLiteral(resourceName: "divider")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var collapseMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrow_up"), for: .normal)
        button.backgroundColor = AppColor.background.uiColor
        button.tintColor = AppColor.heading.uiColor
        button.layer.borderWidth = 0.4
        button.layer.borderColor = AppColor.border.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var orderListLabel: UILabel = {
        let label = UILabel()
        label.text = "1 x Medium Supremo Pizza"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var costOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "$14.40"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderListCostStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 104
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var secondOrderListLabel: UILabel = {
        let label = UILabel()
        label.text = "1 x Small Chicken Pizza"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var secondCostOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "$15.20"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var secondOrderListCostStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 130
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var thirdOrderListLabel: UILabel = {
        let label = UILabel()
        label.text = "1 x Pesto Tomato Pizza"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var thirdCostOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "$10.95"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var thirdOrderListCostStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 130
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var ordersListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var reorderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.grey100.uiColor
        button.setTitle("REORDER", for: .normal)
        button.setTitleColor(AppColor.heading.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.medium.s15()
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
        contentView.backgroundColor = AppColor.background.uiColor
        
        [
            orderNameLabel,
            orderStatusLabel,
            dataPriceLabelsStackView,
            dividerImageView,
            collapseMenuButton,
            ordersListStackView,
            reorderButton
        ].forEach { contentView.addSubview($0) }
        
        [
            orderDataLabel,
            orderPriceLabel
        ].forEach { dataPriceLabelsStackView.addArrangedSubview($0) }
        
        [
            orderListLabel,
            costOrderLabel
        ].forEach { orderListCostStackView.addArrangedSubview($0) }
        [
            secondOrderListLabel,
            secondCostOrderLabel
        ].forEach { secondOrderListCostStackView.addArrangedSubview($0) }
        [
            thirdOrderListLabel,
            thirdCostOrderLabel
        ].forEach { thirdOrderListCostStackView.addArrangedSubview($0) }
        [
            orderListCostStackView,
            secondOrderListCostStackView,
            thirdOrderListCostStackView
        ].forEach { ordersListStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        orderNameLabel.snp.makeConstraints { make in
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
            make.top.equalTo(orderNameLabel.snp.bottom).offset(8)
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
        
        ordersListStackView.snp.makeConstraints { make in
            make.top.equalTo(collapseMenuButton.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        reorderButton.snp.makeConstraints { make in
            make.top.equalTo(ordersListStackView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
    }
}
