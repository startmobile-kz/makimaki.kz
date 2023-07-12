//
//  SearchV1ViewController.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 06.06.2023.
//

import UIKit
import SnapKit

// MARK: - Search Container View protocol

protocol SearchViewControllerDelegate: AnyObject {
    func recentSearchTapped(word: String)
}

final class SearchV1ViewController: UIViewController {
        
    // MARK: - Properties
    
    weak var delegate: SearchViewControllerDelegate?
    private let viewModel = SearchViewModel()
    private var isSearchTextFieldEmpty = true
    private var clearButtonTapped = true
    
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
        viewModel.fetchProducts()
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
            $0.top.equalTo(searchContainerView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
}

extension SearchV1ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchTextFieldEmpty {
            searchTableView.rowHeight = 37
            return viewModel.searchHistory.count
        }
        searchTableView.rowHeight = 66
        return viewModel.filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearchTextFieldEmpty {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecentSearchesTableViewCell.reuseID,
                for: indexPath
            ) as? RecentSearchesTableViewCell else {
                fatalError("recent not found")
            }
            let viewModel = viewModel.createRecentSearchViewModel(
                history: viewModel.searchHistory[indexPath.row])
            cell.configure(with: viewModel)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.reuseID,
            for: indexPath
        ) as? SearchResultTableViewCell else {
            fatalError("recent not found")
        }
        let viewModel = viewModel.createSearchResultViewModel(
            product: viewModel.filteredProducts[indexPath.row])
        cell.configure(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearchTextFieldEmpty {
            delegate?.recentSearchTapped(word: viewModel.searchHistory[indexPath.row].name)
            searchContainerView.recentSearchTapped(word: viewModel.searchHistory[indexPath.row].name)
            isSearchTextFieldEmpty = false
            searchTableView.reloadData()
        } else {
            let dishViewController = DishViewController()
            dishViewController.product = viewModel.filteredProducts[indexPath.row]
            dishViewController.delegate = self
            present(dishViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if isSearchTextFieldEmpty {
            let header = RecentHeaderView()
            header.backgroundColor = AppColor.background.uiColor
            return header
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isSearchTextFieldEmpty ? 18 : 0
    }
}

// MARK: - SearchContainerViewDelegate

extension SearchV1ViewController: SearchContainerViewDelegate {
    func textFieldIsEmpty(state: Bool) {
        isSearchTextFieldEmpty = state
        searchTableView.reloadData()
    }
    
    func clearButtonTapped(isTapped: Bool) {
        clearButtonTapped = isTapped
        viewModel.filteredProducts = viewModel.products
        isSearchTextFieldEmpty = true
        searchTableView.reloadData()
    }
    
    func returnButtonTapped(lastWord: String) {
        viewModel.addToHistory(name: lastWord)
    }
        
    func searchCompleted(word: String) {
        if word.isEmpty {
            viewModel.filteredProducts = viewModel.products
            isSearchTextFieldEmpty = true
            searchTableView.reloadData()
        } else {
            viewModel.filteredProducts = viewModel.products.filter {
                $0.name.lowercased().contains(word.lowercased())
            }
        }
    }
}

// MARK: - Add to basket delegate

extension SearchV1ViewController: DishViewControllerDelegate {
    func addToBasket(dish: RestaurantProduct) {
        // Here need to implement logic of adding to basket VC
    }
}
