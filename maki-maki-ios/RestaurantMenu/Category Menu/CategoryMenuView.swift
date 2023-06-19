//
//  CategoryMenuView.swift
//  maki-maki-ios
//
//  Created by Tami on 15.06.2023.
//

import UIKit
import SnapKit

final class CategoryMenuView: UIView {
    
    // MARK: - State
    
    private var listCategory: [CategoryItem] = [
        CategoryItem(title: "Most Popular", id: .mostPopular),
        CategoryItem(title: "Pizza", id: .pizza),
        CategoryItem(title: "Sushi", id: .sushi),
        CategoryItem(title: "Rolls", id: .rolls),
        CategoryItem(title: "Burgers", id: .burgers),
        CategoryItem(title: "Breakfast", id: .breakfast),
        CategoryItem(title: "Sandwichs", id: .sandwichs),
        CategoryItem(title: "Kebab", id: .kebab),
        CategoryItem(title: "Salads", id: .salads),
        CategoryItem(title: "French Fries", id: .frenchFries),
        CategoryItem(title: "Cold Drinks", id: .coldDrinks)
    ]
    
    static let notificationName = Notification.Name("categoriesItemSelected")
    
    // MARK: - UI
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            DishCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: DishCategoryCollectionViewCell.reuseID)
        return collection
    }()
    
    // MARK: - Setup Collection View
    
    private func setupCollection() {
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.bounces = false
        categoryCollectionView.selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
    
    // MARK: - Layout for CollectionView
    
    private func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        return layout
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        setupCollection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 40)
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        addSubview(categoryCollectionView)
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        categoryCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource methods

extension CategoryMenuView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DishCategoryCollectionViewCell.reuseID,
            for: indexPath) as? DishCategoryCollectionViewCell else {
            fatalError("Couldn't cast to DishCategoryCollectionViewCell")
        }
        cell.categoryLabel.text = listCategory[indexPath.item].title
        return cell
    }
}

// MARK: - UICollectionViewDelegate methods

extension CategoryMenuView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let userInfo = ["sectionIndex": indexPath.row]
        NotificationCenter.default.post(
            name: CategoryMenuView.notificationName,
            object: nil,
            userInfo: userInfo
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout methods

extension CategoryMenuView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 28.0
        let categoryFont = AppFont.reqular.s14()
        let categoryAttribuites = [NSAttributedString.Key.font: categoryFont as Any]
        let categoryWidth = listCategory[indexPath.item].title.size(
            withAttributes: categoryAttribuites).width + padding
        return CGSize(width: categoryWidth, height: collectionView.frame.height)
    }
}
