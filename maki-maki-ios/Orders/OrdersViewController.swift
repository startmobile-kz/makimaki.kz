//
//  OrdersTableViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 03.06.2023.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    // MARK: - State
    
    lazy var orders: [Orders] = {
        return [
            Orders(cafeName: "Bellissimo Pizza",
                        status: "Delivered",
                        time: "31 May 2020, 07:55 PM  ",
                        price: "$43.95",
                        ordersList: self.firstOrder),
            Orders(cafeName: "Capital One Cafe",
                        status: "Cancelled",
                        time: "24 May 2020, 04:50 PM  ",
                        price: "$5.48",
                        ordersList: self.secondOrder),
            Orders(cafeName: "Street Cafe",
                        status: "Delivered",
                        time: "18 May 2020, 02:37 PM  ",
                        price: "$18.30",
                        ordersList: self.thirdOrder),
            Orders(cafeName: "Smile House Cafe",
                        status: "Delivered",
                        time: "18 May 2020, 02:08 PM  ",
                        price: "$14.00",
                        ordersList: self.fouthOrder)
        ]
    }()
    
    var firstOrder: [OrdersList] = [
        OrdersList(count: 1, positionName: " x Burger", price: "$14.40"),
        OrdersList(count: 11, positionName: " x Fanta", price: "$15.20"),
        OrdersList(count: 12, positionName: " x Cola", price: "$10.95"),
        OrdersList(count: 131, positionName: " x Burger", price: "$14.40"),
        OrdersList(count: 9, positionName: " x Fanta", price: "$15.20"),
        OrdersList(count: 2, positionName: " x Cola", price: "$10.95"),
        OrdersList(count: 17, positionName: " x Burger", price: "$14.40"),
        OrdersList(count: 5, positionName: " x Fanta", price: "$15.20"),
        OrdersList(count: 99, positionName: " x Cola", price: "$10.95")
    ]
    
    let secondOrder: [OrdersList] = [
        OrdersList(count: 1, positionName: " x Medium Supremo Pizza", price: "$14.40")
    ]
    
    let thirdOrder: [OrdersList] = []
    
    let fouthOrder: [OrdersList] = [
        OrdersList(count: 1, positionName: " x Medium Supremo Pizza", price: "$14.40"),
        OrdersList(count: 333, positionName: " x Medium Supremo Pizza", price: "$14.40")
    ]
    
    private var ordersCopy: [Orders] = []
    
    private var sectionIsExpanded: [Bool] = []
    
    // MARK: - UI
    
    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.reuseID)
        tableView.register(ReorderCell.self, forCellReuseIdentifier: ReorderCell.reuseID)
        tableView.rowHeight = 36
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundView = noOrdersView
        return tableView
    }()
    
    private lazy var ordersLabel: UILabel = {
        let label = UILabel()
        label.text = "Orders"
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s32()
        label.isHidden = true
        return label
    }()
    
    private lazy var noOrdersView: NoOrdersView = {
        let view = NoOrdersView()
//        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
        setupData()
        showNoOrdersViewIfNeeded()
    }
    
    // MARK: - SetupData
    
    private func setupData() {
        ordersCopy = orders
        sectionIsExpanded = Array(repeating: true, count: orders.count)
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Orders"
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([ordersTableView, ordersLabel])
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        ordersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        ordersLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(21.4)
            make.leading.equalToSuperview().offset(16)
        }
        
        noOrdersView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
    
    private func showNoOrdersViewIfNeeded() {
        if orders.isEmpty {
            ordersTableView.backgroundView = noOrdersView
        } else {
            ordersTableView.backgroundView = nil
        }
    }
}

// MARK: - UITableView Data Source and Delegate methods

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders[section].ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == orders[indexPath.section].ordersList.count - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReorderCell.reuseID,
                                                           for: indexPath) as? ReorderCell else {
                fatalError("reorder_cell not found")
            }
            cell.delegate = self
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrdersCell.reuseID,
                                                       for: indexPath) as? OrdersCell else {
            fatalError("orders_cell is not registered")
        }
        cell.setup(model: orders[indexPath.section].ordersList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == orders[indexPath.section].ordersList.count - 1 {
            return 83
        } else {
            return UITableView.automaticDimension
        }
        
    }
    
    // MARK: - Header of Section
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = OrdersTableHeaderView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: UIScreen.main.bounds.width,
                                                             height:114),
                                               isExpanded: sectionIsExpanded[section])
        headerView.delegate = self
        headerView.setUp(model: orders[section], section: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 114
    }
}

// MARK: - Collapse Animation

extension OrdersViewController: OrdersTableHeaderViewDelegate {
    func onCollapseMenuButtonDidPressed(section: Int, isExpanded: Bool) {
        var indexPathes: [IndexPath] = []
        for i in stride(from: 0, to: ordersCopy[section].ordersList.count, by: 1) {
            indexPathes.append(IndexPath(row: i, section: section))
        }
        sectionIsExpanded[section] = !sectionIsExpanded[section]
        if !isExpanded {
            self.orders[section].ordersList = []
            ordersTableView.deleteRows(at: indexPathes, with: .fade)
        } else {
            orders[section].ordersList = ordersCopy[section].ordersList
            ordersTableView.insertRows(at: indexPathes, with: .fade)
        }
    }
}

// MARK: - Navigation Action

extension OrdersViewController: ReorderCellDelegate {
    func onReorderButtonPressed() {
        self.navigationController?.pushViewController(BasketViewController(), animated: true)
    }
}
