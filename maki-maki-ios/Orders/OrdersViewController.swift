//
//  OrdersTableViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 03.06.2023.
//

import UIKit

class OrdersViewController: UIViewController {
    
    // MARK: - UI
    
    let orders: [OrdersModel] = [ //private?
            OrdersModel(cafeName: "Bellissimo Pizza", status: "Delivered", time: "31 May 2020, 07:55 PM  ", point: "•", price: "$43.95"),
            OrdersModel(cafeName: "Bellissimo Pizza", status: "Delivered", time: "31 May 2020, 07:55 PM  ", point: "•", price: "$43.95"),
            OrdersModel(cafeName: "Bellissimo Pizza", status: "Delivered", time: "31 May 2020, 07:55 PM  ", point: "•", price: "$43.95"),
            OrdersModel(cafeName: "Bellissimo Pizza", status: "Delivered", time: "31 May 2020, 07:55 PM  ", point: "•", price: "$43.95")
        ]
    
    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.reuseID)
        tableView.rowHeight = 301
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Orders"

//        self.navigationController?.title = "Orders"
//        edgesForExtendedLayout = []
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

// MARK: - UICollectionView Data Source and Delegate methods

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrdersCell.reuseID,
                                                       for: indexPath) as? OrdersCell else {
            fatalError("orders_cell is not registered")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
