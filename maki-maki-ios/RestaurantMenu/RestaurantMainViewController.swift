//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class RestaurantMainViewController: UIViewController {
    
    // MARK: - UI
    
    private let categoryName: [String] = ["Most popular",
                                          "Suchi",
                                          "Burgers",
                                          "Rolls",
                                          "Pizza",
                                          "Breakfast",
                                          "Sandwichs",
                                          "Kebab",
                                          "Salads",
                                          "French Fries",
                                          "Cold Drinks"]
    
    private lazy var CategoryMenuCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        collection.backgroundColor = .none
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(CategoryMenuCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.selectItem(at: [0,0], animated: true, scrollPosition:[])
        return collection
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        return layout
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.navigationItem.title = "Title"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubview(CategoryMenuCollectionView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        CategoryMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RestaurantMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath)
            as? CategoryMenuCollectionViewCell else { return UICollectionViewCell() }
        cell.categoryLabel.text = categoryName[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RestaurantMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RestaurantMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryFont = UIFont(name: "Arial", size: 16)
        let categoryAttribuites = [NSAttributedString.Key.font : categoryFont as Any]
        let categoryWidth = categoryName[indexPath.item].size(withAttributes: categoryAttribuites).width + 30
        return CGSize(width: categoryWidth, height: collectionView.frame.height )
    }
}
