//
//  PaymentsViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 12.06.2023.
//

import UIKit

final class PaymentsViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var paymentsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PaymentsTableViewCell.self, forCellReuseIdentifier: "paymentsCell")
        tableView.register(ApplePayCardTableViewCell.self, forCellReuseIdentifier: "applePay")
        tableView.rowHeight = 96
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupViews()
        setupConstraints()

    }
    
    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        self.navigationItem.title = "Payments"
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(paymentsTableView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        paymentsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 2 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "applePay", for: indexPath)
//                    as? ApplePayCardTableViewCell else {
//                fatalError("applePay not found")
//            }
//            cell.layer.borderWidth = 1
//            cell.layer.cornerRadius = 16
//            cell.layer.borderColor = AppColor.border.cgColor
//            return cell
//        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paymentsCell", for: indexPath)
                as? PaymentsTableViewCell else {
            fatalError("paymentsCell not found")
        }
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paymentsCell", for: indexPath)
        //            as? PaymentsTableViewCell else {
        //            fatalError("paymentsCell not found")
        //        }
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 16
//        cell.layer.borderColor = AppColor.border.cgColor
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let footerView = AddNewCardTableViewCell()
    //        return footerView
    //    }

}
