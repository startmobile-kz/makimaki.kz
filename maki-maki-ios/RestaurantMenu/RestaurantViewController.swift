//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class RestaurantViewController: UIViewController {
    // MARK: - Enumeration for dish sections
    
    private let sections: [SectionDishesType] = [.mostPopular, .pizza, .kebab,
                                                .breakfast, .burgers,.coldDrinks,
                                                .frenchFries, .rolls, .sushi,
                                                .salads, .sandwichs]
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DishesCollectionViewCell.self,
                                forCellWithReuseIdentifier: DishesCollectionViewCell.reuseID
        )
        collectionView.register(DishSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DishSectionHeaderView.reuseId)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        self.edgesForExtendedLayout = []
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([collectionView])
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
 
    // MARK: - Layout for CollectionView
    
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
                top: 4,
                leading: 16,
                bottom: 16,
                trailing: 0
            )
            section.interGroupSpacing = 14
            section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            return section
        }
    }
    
    // MARK: - Layout for SectionHeader of Section

    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(36)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

// MARK: - UICollectionViewDelegate methods

extension RestaurantViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource methods

extension RestaurantViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .mostPopular:
            return 5
        case .pizza:
            return 6
        case .sushi:
            return 6
        case .rolls:
            return 6
        case .burgers:
            return 3
        case .breakfast:
            return 4
        case .sandwichs:
            return 3
        case .kebab:
            return 3
        case .salads:
            return 3
        case .frenchFries:
            return 3
        case .coldDrinks:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DishesCollectionViewCell.reuseID,
            for: indexPath) as? DishesCollectionViewCell else {
            fatalError("Could not cast to DishesCollectionViewCell")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DishSectionHeaderView.reuseId,
                for: indexPath) as? DishSectionHeaderView else {
                return  UICollectionReusableView()
            }
            
            let section = sections[indexPath.section]
            switch section {
            case .mostPopular:
                sectionHeader.setSectionHeaderTitle(title: "")
            case .pizza:
                sectionHeader.setSectionHeaderTitle(title: "Classic Pizza")
                
            case .sushi:
                sectionHeader.setSectionHeaderTitle(title: "Sushi")
                
            case .rolls:
                sectionHeader.setSectionHeaderTitle(title: "Rolls")
                
            case .burgers:
                sectionHeader.setSectionHeaderTitle(title: "Burgers")
                
            case .breakfast:
                sectionHeader.setSectionHeaderTitle(title: "Breakfast")
                
            case .sandwichs:
                sectionHeader.setSectionHeaderTitle(title: "Sandwichs")
                
            case .kebab:
                sectionHeader.setSectionHeaderTitle(title: "Kebab")
                
            case .salads:
                sectionHeader.setSectionHeaderTitle(title: "Salads")
                
            case .frenchFries:
                sectionHeader.setSectionHeaderTitle(title: "French Fries")
                
            case .coldDrinks:
                sectionHeader.setSectionHeaderTitle(title: "Cold Drinks")
                
            }
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
}
