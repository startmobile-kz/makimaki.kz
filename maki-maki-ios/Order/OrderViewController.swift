//
//  OrderViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 30.05.2023.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Order"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.backgroundColor = .blue
        return label
    }()
    
    lazy var orderTableVIew: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        return tableView
    }()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .blue
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.backgroundColor = .blue
        return label
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHECKOUT", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.backgroundColor = .yellow
        button.tintColor = .black
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var checkoutPriceLabel: UILabel = {
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
    
    private func setupViews(){
        view.backgroundColor = .white
        
        view.addSubview(orderLabel)
        view.addSubview(orderTableVIew)
        view.addSubview(totalLabel)
        view.addSubview(priceLabel)
        view.addSubview(checkoutButton)
        view.addSubview(checkoutPriceLabel)
        
    }
    
    // MARK: - Setup Constrains
    
    private func setupConstrains() {
        
        orderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(97)
        }
        orderTableVIew.snp.makeConstraints { make in
            make.leading.trailing.equalTo(orderLabel)
            make.trailing.equalTo(orderLabel)
            make.height.equalTo(474.5)
            make.top.equalTo(orderLabel.snp.bottom)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.leading.equalTo(orderLabel)
            make.top.equalTo(orderTableVIew.snp.bottom).offset(30)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(orderTableVIew.snp.bottom).offset(24)
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
