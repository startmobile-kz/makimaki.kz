//
//  ManageAdressesViewController.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 07.06.2023.
//

import UIKit
import SnapKit

class ManageAdressesViewController: UIViewController {
    
    // MARK: - UI
    private lazy var savedAddressesLable: UILabel = {
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
        tableView.register(ManageAdressesCell.self, forCellReuseIdentifier: "Adresscell")
        // tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(TableFooter.self, forHeaderFooterViewReuseIdentifier: "footer")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    var adress: [Adress] = []
    
    // MARK: - Lifecyclu
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        adress = fetchAdress()
        setUI()
        constraitsUI()
        view.backgroundColor = .white
    }
    
    // MARK: - Set UI
    func setUI() {
        view.addSubview(tableView)
        view.addSubview(savedAddressesLable)
    }
    
    // MARK: - Constraint
    func constraitsUI() {
        tableView.snp.makeConstraints { make in
            // make.edges.equalToSuperview()
            make.top.equalTo(savedAddressesLable.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        savedAddressesLable.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(122)
            make.height.equalTo(18)
        }
    }
}

// MARK: - Extension: ManageAdressesViewController

extension ManageAdressesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Adresscell",
            for: indexPath
        ) as? ManageAdressesCell else {
            fatalError("Could not cast to CategoryCollectionViewCell")
        }
        let adress = adress[indexPath.row]
        cell.set(address: adress)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        adress.remove(at: indexPath.row)
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
        let adress1 = Adress(imageAdress: AppImage.homeMA, nameLable: "Home", addressLable: "Navoi 37")
        let adress2 = Adress(imageAdress: AppImage.workMA, nameLable: "Work", addressLable: "Baizakova 280")
        let adress3 = Adress(imageAdress: AppImage.locationMA, nameLable: "Other", addressLable: "Bereke 56")
        
        return [adress1, adress2, adress3]
    }
}
