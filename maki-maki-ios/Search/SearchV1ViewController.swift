//
//  SearchV1ViewController.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 06.06.2023.
//

import UIKit
import SnapKit

final class SearchV1ViewController: UIViewController {

    // MARK: - Properties
    
    private var service = ProductsService()
    private var products = [Product]()
    private var searchTextFieldIsTapped = true
    
    var filteredProducts = [Product]() {
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
        searchTextFieldIsTapped = false
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
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchContainerView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
    
    private func fetchProducts() {
        service.fetchProducts { products in
            DispatchQueue.main.async { [weak self] in
                self?.products = products
                self?.filteredProducts = products
                self?.searchTableView.reloadData()
            }
        }
    }
}

extension SearchV1ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchTextFieldIsTapped {
            searchTableView.rowHeight = 40
            return 6
        }
        searchTableView.rowHeight = 66
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !searchTextFieldIsTapped {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecentSearchesTableViewCell.reuseID,
                for: indexPath
            ) as? RecentSearchesTableViewCell else {
                fatalError("recent not found")
            }
            return cell
        }
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
    func textFieldIsTapped(state: Bool) {
        searchTextFieldIsTapped = state
        searchTableView.reloadData()
    }
    
    func searchCompleted(word: String) {
        if word.isEmpty {
            filteredProducts = products
            searchTableView.reloadData()
        } else {
            filteredProducts = products.filter {
                $0.name.lowercased().contains(word.lowercased())
            }
        }
    }
}
