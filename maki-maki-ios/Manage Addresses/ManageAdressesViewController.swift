//
//  ManageAdressesViewController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import UIKit
import SnapKit

final class ManageAdressesViewController: UIViewController {
    
    // MARK: - UI
    private lazy var savedAddressesLabel: UILabel = {
       let lable = UILabel()
        lable.text = "SAVED ADDRESSES"
        lable.font = AppFont.medium.s15()
        lable.textColor = AppColor.paragraph.uiColor
        return lable
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 78
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ManageAddressesCell.self, forCellReuseIdentifier: "Adresscell")
        tableView.register(AddressTableViewFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    var addresses: [Adress] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addresses = fetchAdress()
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Views
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(savedAddressesLabel)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(savedAddressesLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        savedAddressesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(122)
            make.height.equalTo(18)
        }
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
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        addresses.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }

    // MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
        return footer
    }
}

extension ManageAdressesViewController {
    func fetchAdress() -> [Adress] {
        let adress1 = Adress(image: AppImage.homeMA, title: "Home", subTitle: "Navoi 37")
        let adress2 = Adress(image: AppImage.workMA, title: "Work", subTitle: "Baizakova 280")
        let adress3 = Adress(image: AppImage.locationMA, title: "Other", subTitle: "Bereke 56")
        return [adress1, adress2, adress3]
    }
}
