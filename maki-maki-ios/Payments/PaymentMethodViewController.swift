//
//  PaymentMethodViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 12.06.2023.
//

import UIKit

final class PaymentMethodViewController: UIViewController {
    
    // MARK: - UI
    
    var selectedCheckBoxIndex: IndexPath?
    
    private lazy var paymentMethodTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PaymentMethodTableViewCell.self, forCellReuseIdentifier: "paymentMethod")
        tableView.rowHeight = 96
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var payNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.accent.uiColor
        button.layer.cornerRadius = 14
        button.setTitle("PAY NOW", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.tintColor = AppColor.heading.uiColor
        button.titleLabel?.font = AppFont.medium.s15()
        return button
    }()
    
    private lazy var payNowPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$43.95"
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
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
        self.navigationItem.title = "Payment Method"
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [paymentMethodTableView, payNowButton, payNowPriceLabel].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        paymentMethodTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        payNowButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-29)
            make.height.equalTo(53)
        }
        
        payNowPriceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(payNowButton.snp.trailing).offset(-16)
            make.centerY.equalTo(payNowButton)
        }
    }
}

extension PaymentMethodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paymentMethod", for: indexPath)
                as? PaymentMethodTableViewCell else {
            fatalError("paymentMethod not found")
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        if let selectedCheckBoxIndex = selectedCheckBoxIndex {
            cell.didSelect(value: selectedCheckBoxIndex == indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCheckBoxIndex = indexPath
        tableView.reloadData()
    }
}
