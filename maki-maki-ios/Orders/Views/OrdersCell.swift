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
    
    private lazy var orderCountLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.reqular.s15()
        label.textColor = AppColor.heading.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var orderListLabel: UILabel = {
        let label = UILabel()
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
        [orderCountLabel, orderListLabel, costOrderLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        orderCountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        orderListLabel.snp.makeConstraints { make in
            make.leading.equalTo(orderCountLabel.snp.trailing)
            make.centerY.equalToSuperview()
        }
        
        costOrderLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setup(model: OrdersList) {
        orderCountLabel.text = String(model.count)
        orderListLabel.text = model.positionName
        costOrderLabel.text = model.price
    }
}
