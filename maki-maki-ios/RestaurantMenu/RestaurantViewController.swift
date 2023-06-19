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
    
    private let sections: [SectionDishesType] = [.mostPopular, .pizza, .sushi,
                                                .rolls, .burgers, .breakfast,
                                                .sandwichs, .kebab, .salads,
                                                .frenchFries, .coldDrinks]
    
    // MARK: - Properties
    
    private let numberOfItemsInSection = [5, 6, 6, 6, 3, 5, 5, 5, 5, 5, 5]
    private var currentSection = 0
    private var heights: [Double] = []
    static let notificationName = Notification.Name("scrolledToSection")
    
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
        let view = ViewCartConatiner()
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNotificationObservers()
        calculateAllSectionHeights()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    // MARK: - SetupNotificationObservers
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(scrollToSection),
            name: CategoryMenuView.notificationName,
            object: nil
        )
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
    
    // MARK: - ScrollViewDidScroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let heightOfTwoRows: Double = 2 * 242
        if yOffset >= heights[currentSection] - navBarHeight {
            currentSection += 1
            sendNotification(section: currentSection)
        } else if currentSection > 0 && yOffset < heights[currentSection - 1] - heightOfTwoRows {
            currentSection -= 1
            sendNotification(section: currentSection)
        }
            
    }
    
    private func sendNotification(section: Int) {
        let userInfo = ["categoryIndex": section]
        NotificationCenter.default.post(
            name: RestaurantViewController.notificationName,
            object: nil,
            userInfo: userInfo
        )
    }
    
    private func calculateAllSectionHeights() {
        let headerHeight: Double = 342
        let itemHeight: Double = 242
        let spacingBetweenItems: Double = 14
        
        for i in stride(from: 0, to: sections.count, by: 1) {
            let numOfElementsInSection = ceil(Double(numberOfItemsInSection[i]) / 2) - 1
            let totalHeightOfItems =
            numOfElementsInSection * itemHeight + (numOfElementsInSection - 1) * spacingBetweenItems
            var heightOfSection = headerHeight + totalHeightOfItems - 32
            
            if i > 0 {
                heightOfSection += heights[i - 1]
            }
            heights.append(heightOfSection)
        }
    }
    
    // MARK: - Actions
    
    @objc func scrollToSection(_ notification: Notification) {
        let sectionIndex = notification.userInfo?["sectionIndex"] as? Int ?? 0
        collectionView.scrollToItem(
            at: IndexPath(row: 0, section: sectionIndex),
            at: .centeredVertically,
            animated: true
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
        return numberOfItemsInSection[section]
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
}
