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
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "favoritesCell")
        tableView.rowHeight = 90
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
        view.addSubview(favoritesTableView)
    }
    
    // MARK: - Setup constraints

    private func setupConstraints() {
        
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
        return cell
    }
}
