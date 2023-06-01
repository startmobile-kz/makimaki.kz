//
//  OrderViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 31.05.2023.
//

import UIKit
import SnapKit

final class OrderViewController: UIViewController {
    
    //MARK: - UI
    
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
        label.text = "31 May 2020, 07:55 PM  •"
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
    
    private lazy var collapseMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowUp"), for: .normal)
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraintsWithSnapkit()
    }
    
    //MARK: - Setup Views
    
    private func setupNavigationBar() {
        title = "Orders"
        edgesForExtendedLayout = []
    }
    
    private func setupViews() {
        self.view.backgroundColor = AppColor.background.uiColor
        
        [orderNameLabel, orderStatusLabel, dataPriceLabelsStackView, collapseMenuButton, ordersListStackView, reorderButton].forEach { view.addSubview($0) }
        
        [orderDataLabel, orderPriceLabel].forEach { dataPriceLabelsStackView.addArrangedSubview($0) }
        
        [orderListLabel, costOrderLabel].forEach { orderListCostStackView.addArrangedSubview($0) }
        [secondOrderListLabel, secondCostOrderLabel].forEach { secondOrderListCostStackView.addArrangedSubview($0) }
        [thirdOrderListLabel, thirdCostOrderLabel].forEach { thirdOrderListCostStackView.addArrangedSubview($0) }
        
        [orderListCostStackView, secondOrderListCostStackView, thirdOrderListCostStackView].forEach {ordersListStackView.addArrangedSubview($0)}
    }
    
    private func setupConstraintsWithSnapkit() {
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
