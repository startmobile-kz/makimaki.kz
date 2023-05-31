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
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        return tableView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHECKOUT", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.backgroundColor = .yellow
        button.tintColor = .black
        button.layer.cornerRadius = 14
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return button
    }()
    
    private lazy var checkoutPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .blue
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
            make.leading.trailing.equalTo(orderLabel)
            make.trailing.equalTo(orderLabel)
            make.height.equalTo(474.5)
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
