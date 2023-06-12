//
//  FavoritesViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 06.06.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var favoritesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "favoritesCell")
        tableView.rowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        self.navigationItem.title = "Favorites"
    }
    
    // MARK: - Setup views
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(favoritesTableView)
    }
    
    // MARK: - Setup constraints

    private func setupConstraints() {
        
        favoritesTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
                as? FavoritesTableViewCell else {
            fatalError("favoritesCell not found")
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
}
