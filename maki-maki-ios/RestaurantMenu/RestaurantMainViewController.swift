//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class RestaurantMainViewController: UIViewController {
    
    // MARK: - Setup UI
    private lazy var collectionView: UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var viewCartContainer: ViewCartConatiner {
        let view = viewCartContainer()
        return view
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Flow Layout
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews(collectionView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(viewCartContainer.snp.top)
        }
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {

    }
}

// MARK: - Extension for CollectionView Data Source
extension RestaurantMainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}

// MARK: - Extension for CollectionView Delegate
extension RestaurantMainViewController: UICollectionViewDelegate {
    
}
