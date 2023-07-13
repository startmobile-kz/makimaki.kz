//
//  ManageAdressesViewController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import UIKit
import SnapKit

final class ManageAdressesViewController: UIViewController {
    
    // MARK: - State
    
    private let sharedViewModel = AddressViewModel()
    
    // MARK: - UI
    
    private lazy var savedAddressesLabel: UILabel = {
        let lable = UILabel()
        lable.text = "SAVED ADDRESSES"
        lable.font = AppFont.medium.s15()
        lable.textColor = AppColor.paragraph.uiColor
        return lable
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 78
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ManageAddressesCell.self, forCellReuseIdentifier: "Adresscell")
        tableView.register(AddressTableViewFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
        loadAddreses()
    }
    
    // MARK: - Setup Views
    
    func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([savedAddressesLabel,tableView])
    }
    
    private func setupNavigationBar() {
        title = "Manage Addresses"
        self.navigationController?.navigationBar.tintColor = AppColor.heading.uiColor
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(savedAddressesLabel.snp.bottom).offset(31)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        savedAddressesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(122)
        }
    }
    
    // MARK: - Load Data
    
    private func loadAddreses() {
        sharedViewModel.reloadDataCallback = { [weak self] in
            self?.tableView.reloadData()
        }
        sharedViewModel.fetchAdresses()
    }
}

// MARK: - Extension: ManageAdressesViewController

extension ManageAdressesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedViewModel.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Adresscell",
            for: indexPath
        ) as? ManageAddressesCell else {
            fatalError("Could not cast to CategoryCollectionViewCell")
        }
        let adress = sharedViewModel.addresses[indexPath.row]
        cell.set(address: adress)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        sharedViewModel.deleteAddress(index: indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    // MARK: - Footer
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer =
        tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as? AddressTableViewFooterView
        footer?.delegate = self
        return footer
    }
}

extension ManageAdressesViewController: AddressTableViewFooterViewDelegate {
    func addAddressButtonDidTap() {
        let controller = SelectLocationViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
