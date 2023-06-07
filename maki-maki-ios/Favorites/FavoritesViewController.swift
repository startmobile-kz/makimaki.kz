//
//  FavoritesViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 06.06.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - UI
    
    
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
        
    }
    
    
    // MARK: - Setup constraints

    private func setupConstraints() {
        
    }
}
