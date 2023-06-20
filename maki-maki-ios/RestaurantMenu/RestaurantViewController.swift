//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit

final class RestaurantViewController: UIViewController {
    
    private var service = DishService()
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
        
        collectionView.register(
            RestaurantHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RestaurantHeaderView.reuseID
        )
        collectionView.register(
            DishesCollectionViewCell.self,
            forCellWithReuseIdentifier: DishesCollectionViewCell.reuseID
        )
        collectionView.register(
            DishSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DishSectionHeaderView.reuseId
        )
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private lazy var viewCartContainerView: UIView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openBasket))
        let view = ViewCartConatiner()
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        service.fetchProducts()
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([collectionView, viewCartContainerView])
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(viewCartContainerView.snp.top)
        }
        
        viewCartContainerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(98)
        }
    }
    // MARK: - Layout for Main Section Header

    private func supplementaryMainHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(342)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    // MARK: - Layout for CollectionView
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Item
            let sectionType = self.sections[sectionIndex]
            
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
            
            switch sectionType {
            case .mostPopular:
                section.boundarySupplementaryItems = [self.supplementaryMainHeaderItem()]
            default:
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            }
            
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
        default:
            return 10
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DishSectionHeaderView.reuseId,
                for: indexPath
            ) as? DishSectionHeaderView else {
                fatalError("Could not cast to DishSectionHeaderView")
            }
            
            let section = sections[indexPath.section]
            switch section {
            case .mostPopular:
                guard let mainHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: RestaurantHeaderView.reuseID,
                    for: indexPath
                ) as? RestaurantHeaderView else {
                    fatalError("Could not cast to RestaurantHeaderView")
                }
                return mainHeader
            case .pizza:
                sectionHeader.setSectionHeaderTitle(title: "Classic Pizza")
                
            case .sushi:
                sectionHeader.setSectionHeaderTitle(title: "Sushi")
                
            case .rolls:
                sectionHeader.setSectionHeaderTitle(title: "Rolls")
                
            case .burgers:
                sectionHeader.setSectionHeaderTitle(title: "Burgers")
            
            default :
                sectionHeader.setSectionHeaderTitle(title: "Default name")
                
            }
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dishViewController = DishViewController()
        dishViewController.dish = service.dishes[Int.random(in: 1...50)]
        present(dishViewController, animated: true)
//        basketViewController.selectedDishes = service.dishes
//        self.navigationController?.pushViewController(basketViewController, animated: true)
    }

    // MARK: - Actions

    @objc private func openBasket() {
        let basketViewController = BasketViewController()
        basketViewController.selectedDishes = service.dishes
        self.navigationController?.pushViewController(basketViewController, animated: true)

    }
}
