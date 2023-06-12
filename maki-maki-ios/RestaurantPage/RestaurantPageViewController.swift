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
        collectionView.register(
            PageHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PageHeaderView.reuseID
        )
        return collectionView
    }()
    
    private lazy var replacementView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.accent.uiColor
        return view
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
                top: 32,
                leading: 16,
                bottom: 40,
                trailing: 0
            )
            section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            return section
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(318)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
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
        view.addSubviews([collectionView, replacementView])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        replacementView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: PageHeaderView.reuseID,
                for: indexPath
            ) as! PageHeaderView
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}
