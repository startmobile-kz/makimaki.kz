//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 31.05.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    //MARK: -UI
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
        collectionView.register(DeliveryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DeliveryHeaderView.reuseID)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseID)
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.reuseID)
        collectionView.register(PromoBannerCollectionViewCell.self, forCellWithReuseIdentifier: PromoBannerCollectionViewCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, env in
            
            if section == 0 {
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
                section.boundarySupplementaryItems = [self.supplementaryDeliveryHeaderItem()]
                return section
            } else if section == 1 {
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
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                return section
            } else {
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
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
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

//MARK: -UICollectionView Delegate methods
extension MainViewController: UICollectionViewDelegate {
    
}

//MARK: -UICollectionView Data Source methods
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        } else if section == 1 {
            return 4
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseID, for: indexPath) as! CategoryCollectionViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoBannerCollectionViewCell.reuseID, for: indexPath) as! PromoBannerCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.reuseID, for: indexPath) as! RestaurantCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: indexPath) as! SectionHeaderView
            
            if indexPath.section == 0 {
                let deliverySectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DeliveryHeaderView.reuseID, for: indexPath) as! DeliveryHeaderView
                return deliverySectionHeader
            } else if indexPath.section == 1 {
                sectionHeader.label.text = "Promo"
            } else {
                sectionHeader.label.text = "Restaurants"
            }
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
}
