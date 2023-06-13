//
//  RestaurantPageViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 12.06.2023.
//

import UIKit
import SnapKit

final class RestaurantPageViewController: UIViewController {
    
    // MARK: - Properties
    private var lastContentOffsetY: CGFloat = 0
    private var isScrollingUp = false
    private let replacementViewHeight: CGFloat = 40
    private let initialHeaderHeight: CGFloat = 318
    private let spacingBetweenHeaderAndSection: CGFloat = 32
    private let reinsurance: CGFloat = 2
    
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
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
                heightDimension: .absolute(initialHeaderHeight)
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
        self.edgesForExtendedLayout = []
        view.backgroundColor = .systemBackground
        view.addSubviews([collectionView, replacementView])
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        replacementView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(40)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var sticked = false
        
        checkScrollDirection(viewOffsetY: scrollView.contentOffset.y)
        
        if replacementView.frame.maxY > replacementViewHeight {
            sticked = true
        } else if scrollView.contentOffset.y > initialHeaderHeight - reinsurance {
            if !sticked {
                replacementView.alpha = 1
                UIView.animate(withDuration: 0.3) { [weak self] in
                    guard let self = self else {
                        return
                    }
                    pinReplacementViewToTheTop()
                    self.replacementView.bringSubviewToFront(self.view)
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        if isScrollingUp {
            if scrollView.contentOffset.y < initialHeaderHeight {
                UIView.animate(withDuration: 0.5) {
                    self.replacementView.alpha = 0
                    self.hideReplacementView()
                    self.view.layoutIfNeeded()
                }
                sticked = false
            }
        }
        lastContentOffsetY = scrollView.contentOffset.y
    }
    
    private func hideReplacementView() {
        replacementView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(40)
        }
    }
    
    private func checkScrollDirection(viewOffsetY: CGFloat) {
        if lastContentOffsetY > viewOffsetY {
            isScrollingUp = true
        } else {
            isScrollingUp = false
        }
    }
    
    private func pinReplacementViewToTheTop() {
        replacementView.snp.remakeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}

// MARK: UICollectionViewDelegate methods
extension RestaurantPageViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource methods
extension RestaurantPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DishCell.reuseID,
            for: indexPath
        ) as? DishCell else {
            fatalError("Could not cast to DishCell")
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: PageHeaderView.reuseID,
                for: indexPath
            ) as? PageHeaderView else {
                fatalError("Could not cast to PageHeaderView")
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}
