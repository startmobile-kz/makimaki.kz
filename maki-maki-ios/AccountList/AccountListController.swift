//
//  AccountListController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 04.06.2023.
//

import UIKit
import SnapKit

class AccountListViewController: UIViewController {

    // MARK: - UI
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 53.5
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AccountListCell.self, forCellReuseIdentifier: "LogoCell")
        return tableView
    }()
    
    var logos: [Logo] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        logos = fetchData()
        setUI()
        constraintsUI()
    }
    
    // MARK: - Set UI
    func setUI() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraints
    func constraintsUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Extension

extension AccountListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCell") as! AccountListCell
        let logo = logos[indexPath.row]
        cell.set(logo: logo)
        return cell
    }
    
}

extension AccountListViewController {
    
    func fetchData() -> [Logo] {
        let logo1 = Logo(image: Images.ordersButtons, title: "My Orders", arrow: Images.arrowButton)
        let logo2 = Logo(image: Images.userButtons, title: "My Profile", arrow: Images.arrowButton)
        let logo3 = Logo(image: Images.likeButtons, title: "Favorites", arrow: Images.arrowButton)
        let logo4 = Logo(image: Images.offerButtons, title: "Offers & Promos", arrow: Images.arrowButton)
        let logo5 = Logo(image: Images.paymentButtons, title: "Payments", arrow: Images.arrowButton)
        let logo6 = Logo(image: Images.locationButtons, title: "Location", arrow: Images.arrowButton)
        return [logo1, logo2, logo3, logo4, logo5, logo6]
    }
}
