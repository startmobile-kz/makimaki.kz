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
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "basketCell")
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: "deliveryCell")
        tableView.rowHeight = 119
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var checkoutContainerView: ContainerView = {
        let view = ContainerView()
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
        setupNavigationBar()
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        self.navigationItem.title = "Order"
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [orderTableView, checkoutContainerView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constrains
    
    private func setupConstrains() {
        orderTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(checkoutContainerView.snp.top)
        }
        
        checkoutContainerView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(120)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath)
                    as? DeliveryTableViewCell else {
                fatalError("deliveryCell not found")
            }

            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath)
                as? BasketTableViewCell else {
            fatalError("basketCell not found")
        }

        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        return cell
    }
}
