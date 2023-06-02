//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 31.05.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    //MARK: - Sections
    let sections: [SectionType] = [.header, .promo, .restaurants]
    
    //MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
        collectionView.register(DeliveryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DeliveryHeaderView.reuseID)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseID)
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.reuseID)
        collectionView.register(PromoBannerCollectionViewCell.self, forCellWithReuseIdentifier: PromoBannerCollectionViewCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
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
        view.backgroundColor = AppColor.background.uiColor
        view.addSubview(collectionView)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, env in
            let section = self?.sections[sectionIndex] ?? .promo
            
            switch section {
            case .header:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                // Group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(70),
                        heightDimension: .absolute(90)
                    ),
                    subitems: [item]
                )
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 28, leading: 16, bottom: 40.5, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                
                if let deliveryHeaderItem = self?.supplementaryDeliveryHeaderItem() {
                    section.boundarySupplementaryItems = [deliveryHeaderItem]
                }
                return section
            case .promo:
                //Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                //Group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(300),
                        heightDimension: .absolute(160)
                    ),
                    subitems: [item]
                )
                //Section
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                
                if let headerItem = self?.supplementaryHeaderItem() {
                    section.boundarySupplementaryItems = [headerItem]
                }
                return section
            case .restaurants:
                //Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(180)
                    )
                )
                item.contentInsets.trailing = 16
                //Group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(236)
                    ),
                    subitems: [item]
                )
                //Section
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 32
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 0)
                
                if let headerItem = self?.supplementaryHeaderItem() {
                    section.boundarySupplementaryItems = [headerItem]
                }
                return section
            }
        }
    }
    
    private func supplementaryDeliveryHeaderItem() ->  NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(61)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(43)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

//MARK: - UICollectionView Delegate methods
extension MainViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionView Data Source methods
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .header:
            return 10
        case .promo:
            return 4
        case .restaurants:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseID, for: indexPath) as! CategoryCollectionViewCell
            return cell
        case .promo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoBannerCollectionViewCell.reuseID, for: indexPath) as! PromoBannerCollectionViewCell
            return cell
        case .restaurants:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.reuseID, for: indexPath) as! RestaurantCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: indexPath) as! SectionHeaderView
            let section = sections[indexPath.section]
            switch section {
            case .header:
                let deliverySectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DeliveryHeaderView.reuseID, for: indexPath) as! DeliveryHeaderView
                return deliverySectionHeader
            case .promo:
                sectionHeader.label.text = "Promo"
            case .restaurants:
                sectionHeader.label.text = "Restaurants"
            }
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
}
