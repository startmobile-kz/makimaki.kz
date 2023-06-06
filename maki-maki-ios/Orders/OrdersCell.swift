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
    
    static let reuseID = "orders_cell"
    
    private lazy var orderListLabel: UILabel = {
        let label = UILabel()
//        label.text = "1 x Medium Supremo Pizza"
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var costOrderLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderListCostStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
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
        contentView.addSubview(orderListCostStackView)
        
        [orderListLabel, costOrderLabel].forEach { orderListCostStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        orderListCostStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setup(model: OrdersList) {
        orderListLabel.text = model.positionName
        costOrderLabel.text = model.price
    }
}
