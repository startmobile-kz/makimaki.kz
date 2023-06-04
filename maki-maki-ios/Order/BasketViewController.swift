//
//  OrderViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 30.05.2023.
//

import UIKit
import SnapKit

final class BasketViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Order"
        label.font = AppFont.bold.s32()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "basketCell")
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: "deliveryCell")
        tableView.rowHeight = 118
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = AppFont.medium.s20()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = AppFont.semibold.s24()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.setTitle("CHECKOUT", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        return button
    }()
    
    private lazy var checkoutPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
        
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [orderLabel, orderTableView, totalLabel, priceLabel, checkoutButton, checkoutPriceLabel].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constrains
    
    private func setupConstrains() {
        orderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(97)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        orderTableView.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            //make.height.equalTo(474.5)
            make.bottom.equalTo(checkoutButton.snp.top).offset(-119.5)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(orderTableView.snp.bottom).offset(30)
            make.leading.equalTo(orderLabel)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(orderTableView.snp.bottom).offset(24)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-29)
            make.height.equalTo(53)
        }
        
        checkoutPriceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(checkoutButton.snp.trailing).offset(-16)
            make.centerY.equalTo(checkoutButton)
        }
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath) as! DeliveryTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketTableViewCell
        return cell
    }
}
