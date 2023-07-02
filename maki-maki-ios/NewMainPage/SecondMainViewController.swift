//
//  SecondMainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 30.06.2023.
//

import UIKit
import SnapKit

class SecondMainViewController: UIViewController {
    
    // MARK: - State
    
    private var service = RestaurantProductService()
    private let sections: [NewMainPageSectionTypes] = [.promos, .products]
    private var categoriesAndNames: [Int: String] = [:]
    private var productsByCategoryMap: [Int: [RestaurantProduct]] = [:]
    
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
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseID
        )
        collectionView.register(
            СategoriesHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: СategoriesHeaderView.reuseID
        )
        collectionView.register(
            ProductSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProductSectionHeaderView.reuseId
        )
        collectionView.register(
            PromoBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: PromoBannerCollectionViewCell.reuseID
        )
        collectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.reuseID
        )
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchCategoriesWithProducts()
    }
    
    // MARK: - SetupView
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([deliveryHeaderView, separatorView, collectionView])
    }
    
    // MARK: - SetupLayout
    
    private func setupConstraints() {
        deliveryHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
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
            
            switch sectionIndex {
            case 0:
                return self?.promosSectionLayout()
            default:
                return self?.productsSectionLayout(sectionIndex: sectionIndex)
            }
        }
    }
    
    // MARK: - Section Layouts
    
    private func promosSectionLayout() -> NSCollectionLayoutSection {
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
            top: 25,
            leading: 16,
            bottom: 25,
            trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func productsSectionLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
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
        switch sectionIndex {
        case 1:
            section.boundarySupplementaryItems = [supplementaryProductsHeaderItem()]
        default:
            section.boundarySupplementaryItems = [supplementaryProductsGroupHeaderItem()]
        }
        return section
    }
    
    private func supplementaryProductsHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(60)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
    
    private func supplementaryProductsGroupHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(36)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
    // MARK: Fetching data
    
    private func fetchCategoriesWithProducts() {
        service.fetchCategoriesWithProducts { [weak self] result in
            switch result {
            case .success(let groupedProducts):
                self?.categoriesAndNames = groupedProducts.categoriesAndNames
                self?.productsByCategoryMap = groupedProducts.dividedProducts
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SecondMainViewController: DeliveryHeaderViewDelegate {
    func viewWasTapped() {
        print("Tapped")
    }
}

// MARK: - UICollectionView Delegate methods

extension SecondMainViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionView DataSource methods

extension SecondMainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count + 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let sectionType = sections[section]
        
        switch section {
        case 0:
            return 5
        default:
            return productsByCategoryMap[section]?.count ?? 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PromoBannerCollectionViewCell.reuseID,
                for: indexPath
            ) as? PromoBannerCollectionViewCell else {
                fatalError("Could not cast to PromoBannerCollectionViewCell")
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCollectionViewCell.reuseID,
                for: indexPath) as? ProductCollectionViewCell else {
                fatalError("Could not cast to DishesCollectionViewCell")
            }
            guard let product = productsByCategoryMap[indexPath.section]?[indexPath.row] else {
                return UICollectionViewCell()
            }
            print(product.name)
            cell.setupData(product: product)
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let section = indexPath.section
            switch section {
            case 1:
                guard let productsSectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: СategoriesHeaderView.reuseID,
                    for: indexPath
                ) as? СategoriesHeaderView else {
                    fatalError("Could not cast to CategoriesHeaderView")
                }
                return productsSectionHeader
            default:
                guard let productsSectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ProductSectionHeaderView.reuseId,
                    for: indexPath
                ) as? ProductSectionHeaderView else {
                    fatalError("Could not cast to ProductSectionHeaderView")
                }
                productsSectionHeader.setSectionHeaderTitle(title: categoriesAndNames[section] ?? "")
                return productsSectionHeader
            }
        } else {
            return UICollectionReusableView()
        }
    }
}
