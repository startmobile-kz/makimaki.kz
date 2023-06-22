//
//  SearchV1ViewController.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 06.06.2023.
//

import UIKit
import SnapKit

final class SearchV1ViewController: UIViewController {

    private var service = ProductsService()
    public var products = [ProductModel]()

    var filteredProducts = [ProductModel]() {
        didSet {
            self.searchTableView.reloadData()
        }
    }

    // MARK: - UI
    private lazy var searchContainerView: SearchContainerView = SearchContainerView()
    
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
        fetchProducts()

        searchContainerView.delegate = self
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(searchContainerView)
        view.addSubview(searchTableView)
        view.backgroundColor = AppColor.background.uiColor
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        searchContainerView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(60)
            make.height.equalTo(48)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchContainerView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    private func fetchProducts() {
        service.fetchProducts { product in
            DispatchQueue.main.async { [weak self] in
                self?.products = product
                self?.filteredProducts = product
                self?.searchTableView.reloadData()
            }
        }
    }
}

extension SearchV1ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.reuseID,
            for: indexPath
        ) as? SearchResultTableViewCell else {
            fatalError("recent not found")
        }
        cell.setupData(dish: filteredProducts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishViewController()
        present(controller, animated: true)
    }
}

// MARK: - SearchContainerViewDelegate

extension SearchV1ViewController: SearchContainerViewDelegate {
    func searchCompleted(word: String) {
        filteredProducts = products.filter({ product in
            product.name.lowercased().contains(word.lowercased())
        })
    }
}
