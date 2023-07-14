//
//  ManageAdressesViewController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import UIKit
import SnapKit

protocol ManageAdressesViewControllerDelegate : AnyObject {
    func updateSelectedAddress(address: Address)
}

final class ManageAdressesViewController: UIViewController {
    // MARK: - State
    
    var addresses: [Address] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    weak var delegate: ManageAdressesViewControllerDelegate?
    private let service: AddressService = AddressService()
    
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
        view.addSubview(tableView)
        view.addSubview(savedAddressesLabel)
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
        addresses = service.fetchAddresses()
    }
}

// MARK: - Extension: ManageAdressesViewController

extension ManageAdressesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Adresscell",
            for: indexPath
        ) as? ManageAddressesCell else {
            fatalError("Could not cast to CategoryCollectionViewCell")
        }
        let adress = addresses[indexPath.row]
        cell.set(address: adress)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedAddress = addresses[indexPath.row]
        selectedAddress.isSelected = true
        delegate?.updateSelectedAddress(address: selectedAddress)
        if delegate != nil {
            delegate?.updateSelectedAddress(address: selectedAddress)
        } else {
            print("Delegate not set")
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
        
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        let currentAddress = addresses[indexPath.row]
        service.deleteAddress(address: currentAddress)
        addresses.remove(at: indexPath.row)
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
