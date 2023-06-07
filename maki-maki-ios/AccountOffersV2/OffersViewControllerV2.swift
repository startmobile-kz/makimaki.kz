//
//  OffersCellV2.swift
//  maki-maki-ios
//
//  Created by Ravil on 07.06.2023.
//

import UIKit
import SnapKit

final class OffersViewControllerV2: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OffersCellV2.self, forCellReuseIdentifier: "offers_cellv2")
        tableView.rowHeight = 88
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

extension OffersViewControllerV2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "offers_cellv2",
            for: indexPath
        ) as? OffersCellV2 else {
            fatalError("Could not cast to CategoryCollectionViewCell")
        }
        return cell
    }
}
