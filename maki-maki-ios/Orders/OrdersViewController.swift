//
//  OrdersTableViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 03.06.2023.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var orders: [OrdersModel] = {
        return [
//            OrdersModel(cafeName: "Bellissimo Pizza",
//                        status: "Delivered",
//                        time: "31 May 2020, 07:55 PM  ",
//                        price: "$43.95",
//                        ordersList: self.firstOrder),
//            OrdersModel(cafeName: "Capital One Cafe",
//                        status: "Cancelled",
//                        time: "24 May 2020, 04:50 PM  ",
//                        price: "$5.48",
//                        ordersList: self.secondOrder),
//            OrdersModel(cafeName: "Street Cafe",
//                        status: "Delivered",
//                        time: "18 May 2020, 02:37 PM  ",
//                        price: "$18.30",
//                        ordersList: self.thirdOrder),
//            OrdersModel(cafeName: "Smile House Cafe",
//                        status: "Delivered",
//                        time: "18 May 2020, 02:08 PM  ",
//                        price: "$14.00",
//                        ordersList: self.fouthOrder)
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
    
    private var ordersCopy: [OrdersModel] = []
    
    private var sectionIsExpanded: [Bool] = []
    
    lazy var ordersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.reuseID)
        tableView.rowHeight = 36
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var noOrdersView: NoOrdersView = {
        let view = NoOrdersView()
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigationBar()
        setupData()
        setupViews()
        setupConstraints()
        showNoOrdersViewIfNeeded()
    }
    
    // MARK: - SetupData
    
    private func setupData() {
        ordersCopy = orders
        sectionIsExpanded = Array(repeating: true, count: orders.count)
    }
    
    // MARK: - Setup Views
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Orders"
    }
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([ordersTableView, noOrdersView])
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        ordersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        noOrdersView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            make.centerX.equalToSuperview()
        }
    }
    
    private func showNoOrdersViewIfNeeded() {
        if orders.isEmpty {
            ordersTableView.isHidden = true
            noOrdersView.isHidden = false
        } else {
            ordersTableView.isHidden = false
            noOrdersView.isHidden = true
        }
    }
}

// MARK: - UICollectionView Data Source and Delegate methods

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders[section].ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrdersCell.reuseID,
                                                       for: indexPath) as? OrdersCell else {
            fatalError("orders_cell is not registered")
        }
        cell.setup(model: orders[indexPath.section].ordersList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
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
    
    // MARK: - Footer of Section
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = OrdersTableFooterView(frame: CGRect(x:0,
                                                             y: 0,
                                                             width: UIScreen.main.bounds.width,
                                                             height:83))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 83
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
