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
        view.backgroundColor = AppColor.background.uiColor
        
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

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "applePay", for: indexPath)
                    as? ApplePayCardTableViewCell else {
                fatalError("applePay not found")
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paymentsCell", for: indexPath)
                as? PaymentsTableViewCell else {
            fatalError("paymentsCell not found")
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
}
