//
//  AccountOffersList.swift
//  maki-maki-ios
//
//  Created by Ravil on 06.06.2023.
//

import UIKit
import SnapKit
import Alamofire

final class OffersViewController: UIViewController {

    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OffersCell.self, forCellReuseIdentifier: "offers_cell")
        tableView.rowHeight = 148
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    // MARK: - setupViews
    
    private func setupViews() {
        view.addSubview(tableView)
    }

    // MARK: - setupConstraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension OffersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "offers_cell",
            for: indexPath
        ) as? OffersCell else {
            fatalError("Could not cast to CategoryCollectionViewCell")
        }
        return cell
    }
}
