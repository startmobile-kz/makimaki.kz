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
        tableView.rowHeight = 119
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var checkoutContainerView: UIViewController = {
        let containerVC = ContainerViewController()
        addChild(containerVC)
        return containerVC
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
        
        view.addSubview(checkoutContainerView.view)
        [orderLabel, orderTableView].forEach {
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(checkoutContainerView.view.snp.top)
        }
        
        checkoutContainerView.view.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-29)
            make.height.equalTo(UIScreen.main.bounds.height/4.029)
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
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        return cell
    }
}
