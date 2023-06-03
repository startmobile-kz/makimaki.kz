//
//  OrdersTableViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 03.06.2023.
//

import UIKit

class OrdersTableViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OrdersCell.self, forCellReuseIdentifier: "orders_cell")
        tableView.rowHeight = 301
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Views
    
    private func setupNavigationBar() {
        title = "Orders"
        edgesForExtendedLayout = []
    }
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubview(ordersTableView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        ordersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension OrdersTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orders_cell", for: indexPath) as! OrdersCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
