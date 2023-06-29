//
//  OrdersTableViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 03.06.2023.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    // MARK: - State
    
    lazy var orders: [Order] = {
        return [
            Order(cafeName: "Maki Maki",
                  status: "Delivered",
                  time: "31 May 2020, 07:55 PM  ",
                  price: "$43.95",
                  ordersList: self.firstOrder),
            Order(cafeName: "Maki Maki",
                  status: "Cancelled",
                  time: "24 May 2020, 04:50 PM  ",
                  price: "$5.48",
                  ordersList: self.secondOrder),
            Order(cafeName: "Maki Maki",
                  status: "Delivered",
                  time: "18 May 2020, 02:37 PM  ",
                  price: "$18.30",
                  ordersList: self.thirdOrder),
            Order(cafeName: "Maki Maki",
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
    
    private var ordersCopy: [Order] = []
    
    private var sectionIsExpanded: [Bool] = []
    
    private var isReorderCellExpanded: [Bool] = []
    
    // MARK: - UI
    
    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.reuseID)
        tableView.register(ReorderCell.self, forCellReuseIdentifier: ReorderCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundView = noOrdersView
        return tableView
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
        isReorderCellExpanded = Array(repeating: true, count: orders.count)
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Orders"
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([ordersTableView])
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        ordersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        if sectionIsExpanded[section] {
            return orders[section].ordersList.count + (isReorderCellExpanded[section] ? 1 : 0)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == orders[indexPath.section].ordersList.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReorderCell.reuseID,
                                                           for: indexPath) as? ReorderCell else {
                fatalError("reorder_cell not found")
            }
            cell.delegate = self
            cell.isHidden = !isReorderCellExpanded[indexPath.section]
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
        if indexPath.row == orders[indexPath.section].ordersList.count {
            return 83
        } else {
            return 36
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
       
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: - Collapse Animation

extension OrdersViewController: OrdersTableHeaderViewDelegate {
    func onCollapseMenuButtonDidPressed(section: Int, isExpanded: Bool) {
        sectionIsExpanded[section] = !sectionIsExpanded[section]
        isReorderCellExpanded[section] = isExpanded
        ordersTableView.reloadData()
        
        if !isExpanded {
            orders[section].ordersList = []
            ordersTableView.reloadData()
        } else {
            orders[section].ordersList = ordersCopy[section].ordersList
            let indexPaths = (0..<orders[section].ordersList.count).map {
                IndexPath(row: $0, section: section)
            }
            ordersTableView.insertRows(at: indexPaths, with: .fade)
        }
    }
}

// MARK: - Navigation Action

extension OrdersViewController: ReorderCellDelegate {
    func onReorderButtonPressed() {
        self.navigationController?.pushViewController(BasketViewController(), animated: true)
    }
}
