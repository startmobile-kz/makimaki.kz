//
//  RestaurantPageViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 12.06.2023.
//

import UIKit
import SnapKit

class RestaurantPageViewController: UIViewController {
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            DishCell.self,
            forCellWithReuseIdentifier: DishCell.reuseID
        )
        return collectionView
    }()
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ in
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets.trailing = 14
            item.contentInsets.bottom = 14
            
            // Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(242)
                ),
                subitems: [item]
            )
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 16,
                bottom: 40,
                trailing: 0
            )
            return section
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews([collectionView])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: UICollectionViewDelegate methods
extension RestaurantPageViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource methods
extension RestaurantPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DishCell.reuseID,
            for: indexPath
        ) as! DishCell
        return cell
    }
}
