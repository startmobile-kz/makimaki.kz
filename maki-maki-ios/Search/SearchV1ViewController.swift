//
//  SearchV1ViewController.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 06.06.2023.
//

import UIKit
import SnapKit

final class SearchV1ViewController: UIViewController, SearchBarDelegate {
    
    var receivedData = ""
    
    func searchDelegate(word: String) {
        self.receivedData = word
    }

    private var service = ProductsService()
    public var products = [ProductModel]()
    
    public var filteredProducts = [ProductModel]()
    
    // MARK: - UI
    private lazy var searchBar: SearchBar = SearchBar()
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchResultTableViewCell.self,
                           forCellReuseIdentifier: SearchResultTableViewCell.reuseID)
        tableView.register(RecentSearchesTableViewCell.self,
                           forCellReuseIdentifier: RecentSearchesTableViewCell.reuseID)
        //  Here need to make logic, when table view decides which cell to display
        tableView.rowHeight = 66
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        callbackService()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(searchTableView)
        view.backgroundColor = AppColor.background.uiColor
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(60)
            make.height.equalTo(48)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    private func callbackService() {
        service.fetchProducts { product in
            self.products = product
            DispatchQueue.main.async { [weak self] in
                self?.searchTableView.reloadData()
            }
        }
    }
}

extension SearchV1ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.reuseID,
            for: indexPath
        ) as? SearchResultTableViewCell else {
            fatalError("recent not found")
        }
        cell.setupData(dish: products[indexPath.row])
        return cell
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        func filterResults() {
//            filteredProducts = products.filter { $0.name.contains(where: {receivedData.contains($0)})}
//            print(filteredProducts)
//        }
//    }
}
