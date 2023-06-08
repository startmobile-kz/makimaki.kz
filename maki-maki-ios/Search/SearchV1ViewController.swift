//
//  SearchV1ViewController.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 06.06.2023.
//

import UIKit

final class SearchV1ViewController: UIViewController {
    
    // MARK: - UI
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search for a dish"
        searchBar.setImage(UIImage(named: "search_icon"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "clear_icon"), for: UISearchBar.Icon.clear, state: .normal)
        searchBar.searchTextField.textColor = AppColor.heading.uiColor
        searchBar.searchTextField.font = AppFont.reqular.s14()
        return searchBar
    }()
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "searchResult_cell")
        tableView.rowHeight = 66
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContrains()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(searchTableView)
        view.backgroundColor = AppColor.background.uiColor
    }

    // MARK: - Setup Constraints
    private func setupContrains() {
        
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
}

extension SearchV1ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult_cell", for: indexPath)
                as? SearchResultTableViewCell else {
            fatalError("searchResultCell not found")
        }
        return cell
    }
    
}
