//
//  OrdersTableViewController.swift
//  maki-maki-ios
//
//  Created by siberianarg on 03.06.2023.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    // MARK: - UI
    
    // этот двухмерный массив использую только для nubersOfSections
    lazy var orders: [OrdersModel] = {
        return [
            OrdersModel(cafeName: "Bellissimo Pizza",
                        status: "Delivered",
                        time: "31 May 2020, 07:55 PM  ",
                        point: "•",
                        price: "$43.95",
                        ordersList: self.firstOrder),
            OrdersModel(cafeName: "KFC",
                        status: "Delivered",
                        time: "31 May 2020, 07:55 PM  ",
                        point: "•",
                        price: "$43.95",
                        ordersList: self.secondOrder),
            OrdersModel(cafeName: "Burger King",
                        status: "Delivered",
                        time: "31 May 2020, 07:55 PM  ",
                        point: "•",
                        price: "$43.95",
                        ordersList: self.thirdOrder),
            OrdersModel(cafeName: "Bahandi",
                        status: "Delivered",
                        time: "31 May 2020, 07:55 PM  ",
                        point: "•",
                        price: "$43.95",
                        ordersList: self.fouthOrder)
        ]
    }()
    
    // пока при работе с ячейками внутри секции работаю с данным массивом
    let firstOrder: [OrdersList] = [
        OrdersList(positionName: "1 x Burger", price: "$14.40"),
        OrdersList(positionName: "1 x Fanta", price: "$15.20"),
        OrdersList(positionName: "1 x Cola", price: "$10.95")
    ]

    let secondOrder: [OrdersList] = [
        OrdersList(positionName: "1 x Medium Supremo Pizza", price: "$14.40")
    ]

    let thirdOrder: [OrdersList] = [
        //        OrdersList(positionName: "1 x Medium Supremo Pizza", price: "$14.40")
    ]

    let fouthOrder: [OrdersList] = [
        OrdersList(positionName: "1 x Medium Supremo Pizza", price: "$14.40"),
        OrdersList(positionName: "1 x Medium Supremo Pizza", price: "$14.40")
    ]

    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.reuseID)
        tableView.rowHeight = 36
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
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
                                                             height:114))
        headerView.setUp(model: orders[section])
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
