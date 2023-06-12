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
        tableView.rowHeight = 80
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paymentsCell", for: indexPath)
            as? PaymentsTableViewCell else {
            fatalError("paymentsCell not found")
        }
        return cell
    }
    
}
