//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 31.05.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class MainViewController: UIViewController {
    
    var categories: [Category] = []
    
    // MARK: - Sections
    let sections: [SectionType] = [.categories, .promos, .restaurants]
    var selectedCategoryIndexPath: IndexPath?
    
    // MARK: - UI
    private lazy var deliveryHeaderView: DeliveryHeaderView = {
        let view = DeliveryHeaderView()
        view.delegate = self
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.border.uiColor
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isSkeletonable = true
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseID
        )
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseID
        )
        collectionView.register(
            PromoBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: PromoBannerCollectionViewCell.reuseID
        )
        collectionView.register(
            RestaurantCollectionViewCell.self,
            forCellWithReuseIdentifier: RestaurantCollectionViewCell.reuseID
        )
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: { [weak self] in
            self?.fetchCategories()
        })
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.isSkeletonable = true
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([deliveryHeaderView, separatorView, collectionView])
    }
    
    // MARK: - SetupSkeletons
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        deliveryHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(deliveryHeaderView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).priority(250)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .promos
            switch section {
            case .categories:
                return self?.categorieSectionLayout()
            case .promos:
                return self?.promoSectionLayout()
            case .restaurants:
                return self?.restaurantSectionLayout()
            }
        }
    }
    
    // MARK: - fetchCategories
    
    private func fetchCategories() {
        CategoryService().fetchCategories { categories in
            self.categories = categories
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Section Layouts
    private func categorieSectionLayout() -> NSCollectionLayoutSection {
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
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 28,
            leading: 16,
            bottom: 40.5,
            trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func promoSectionLayout() -> NSCollectionLayoutSection {
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
                widthDimension: .absolute(300),
                heightDimension: .absolute(160)
            ),
            subitems: [item]
        )
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 40,
            trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func restaurantSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(180)
            )
        )
        item.contentInsets.trailing = 16
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(236)
            ),
            subitems: [item]
        )
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 32
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 20,
            trailing: 0
        )
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
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

// MARK: - DeliveryHeaderViewDelegate
extension MainViewController: DeliveryHeaderViewDelegate {
    func viewWasTapped() {
        // Переходной контроллер еще не готов, так что просто сделал пуш в рандомный
        let controller = ManageAdressesViewController()
//        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionView Delegate methods
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if cell is PromoBannerCollectionViewCell || cell is
            CategoryCollectionViewCell || cell is RestaurantCollectionViewCell {
            cell.showAnimatedGradientSkeleton()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if cell is PromoBannerCollectionViewCell || cell is
            CategoryCollectionViewCell || cell is RestaurantCollectionViewCell {
            cell.stopSkeletonAnimation()
        }
    }
}

// MARK: - UICollectionView Data Source methods
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .categories:
            return categories.count
        case .promos:
            return 30
        case .restaurants:
            return 100
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.reuseID,
                for: indexPath
            ) as? CategoryCollectionViewCell else {
                fatalError("Could not cast to CategoryCollectionViewCell")
            }
            if let selectedCategoryIndexPath = selectedCategoryIndexPath {
                cell.set(value: selectedCategoryIndexPath == indexPath)
            }
            
            if indexPath.item < categories.count {
                let category = categories[indexPath.item]
                cell.setupData(category: category)
            }
            return cell
        case .promos:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PromoBannerCollectionViewCell.reuseID,
                for: indexPath
            ) as? PromoBannerCollectionViewCell else {
                fatalError("Could not cast to PromoBannerCollectionViewCell")
            }
            return cell
        case .restaurants:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RestaurantCollectionViewCell.reuseID,
                for: indexPath
            ) as? RestaurantCollectionViewCell else {
                fatalError("Could not cast to RestaurantCollectionViewCell")
            }
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseID,
                for: indexPath
            ) as? SectionHeaderView else {
                fatalError("Could not cast to SectionHeaderView")
            }
            let section = sections[indexPath.section]
            switch section {
            case .categories:
                return UICollectionReusableView()
            case .promos:
                sectionHeader.setHeaderTitle(title: "Promo")
            case .restaurants:
                sectionHeader.setHeaderTitle(title: "Restaurants")
            }
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .categories:
            selectedCategoryIndexPath = indexPath
            collectionView.reloadData()
        default:
            return
        }
    }
}
// MARK: - SkeletonCollectionViewDataSource
extension MainViewController: SkeletonCollectionViewDataSource {
    private func collectionSkeletonView(_ skeletonView: UITableView,
                                        numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .categories:
            return 20
        case .promos:
            return 30
        case .restaurants:
            return 100
        }
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        if indexPath.section == 0 {
            return CategoryCollectionViewCell.reuseID
        } else if indexPath.section == 1 {
            return PromoBannerCollectionViewCell.reuseID
        } else {
            return RestaurantCollectionViewCell.reuseID
        }
    }
}
