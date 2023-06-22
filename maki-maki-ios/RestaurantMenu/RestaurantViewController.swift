//
//  MainViewController.swift
//  maki-maki-ios
//
//  Created by Tami on 12.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class RestaurantViewController: UIViewController {
    
    // MARK: - Properties
    
    private var lastContentOffsetY: CGFloat = 0
    private var isScrollingUp = false
    private let initialHeaderHeight: CGFloat = 318
    private let spacingBetweenHeaderAndSection: CGFloat = 32
    
    // MARK: - Enumeration for dish sections
    
    private let sections: [SectionDishesType] = [.mostPopular, .pizza, .sushi,
                                                .rolls, .burgers, .breakfast,
                                                .sandwichs, .kebab, .salads,
                                                .frenchFries, .coldDrinks]
    
    // MARK: - Properties
    
    private let numberOfItemsInSection = [5, 6, 5, 4, 5, 5, 7, 7, 8, 8, 8]
    private var currentSection = 0
    private var heights: [Double] = []
    static let notificationName = Notification.Name("scrolledToSection")

    // MARK: - UI
    
    private lazy var categoriesReplacementView: CategoryMenuView = {
        let view = CategoryMenuView()
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var likeBarButtonItem: UIBarButtonItem = {
        let likeImage = AppImage.like_black.uiImage
        let item = UIBarButtonItem(image: likeImage, style: .plain, target: nil, action: nil)
        item.tintColor = .black
        return item
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isSkeletonable = true
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
        collectionView.bounces = false
        return collectionView
    }()
    
    private lazy var viewCartContainerView: ViewCartContainer = {
        let view = ViewCartContainer()
        view.isSkeletonable = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        setupNotificationObservers()
        calculateAllSectionHeights()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.collectionView.stopSkeletonAnimation()
            self?.collectionView.hideSkeleton(transition: .crossDissolve(0.25))
            self?.collectionView.reloadData()
            self?.viewCartContainerView.stopSkeletonAnimation()
            self?.viewCartContainerView.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
        viewCartContainerView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([collectionView, categoriesReplacementView, viewCartContainerView])
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        categoriesReplacementView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-60)
            make.leading.trailing.equalToSuperview()
        }
        
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

    // MARK: - SetupNavigationBar
    
    private func setupNavigationBar() {
        title = ""
        self.navigationController?.navigationBar.topItem?.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItems = []
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
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
        let heightOfOneRowOfItems: Double = 242
        let safeTopInsetHeight = view.safeAreaLayoutGuide.layoutFrame.minY
        if yOffset >= heights[currentSection] - safeTopInsetHeight {
            currentSection += 1
            sendNotification(section: currentSection)
        } else if currentSection > 0 && yOffset < heights[currentSection - 1] - heightOfOneRowOfItems * 2 {
            currentSection -= 1
            sendNotification(section: currentSection)
        }
        
        var sticked = false
        
        checkScrollDirection(viewOffsetY: scrollView.contentOffset.y)
        
       if scrollView.contentOffset.y > initialHeaderHeight {
            if !sticked {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.makeNavigationBarVisible()
                    self.pinCategoriesReplacementViewToTheTop()
                    self.categoriesReplacementView.bringSubviewToFront(self.view)
                    self.view.layoutIfNeeded()
                    sticked = true
                }
            }
        }
        
        if isScrollingUp {
            if scrollView.contentOffset.y < initialHeaderHeight {
                self.hideCategoriesReplacementView()
                self.setupNavigationBar()
                self.view.layoutIfNeeded()
                sticked = false
            }
        }
        lastContentOffsetY = scrollView.contentOffset.y
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
        let itemHeight: Double = 242
        let spacingBetweenItems: Double = 14
        let heightOfBottomInsetOfSections: Double = 16
        
        for sectionIndex in 0..<sections.count {
            let headerHeight: Double = (sectionIndex == 0) ? 342 : 36
            let numfOfRowsInSection = ceil(Double(numberOfItemsInSection[sectionIndex]) / 2)
            let totalHeightOfItems =
            numfOfRowsInSection * itemHeight + (numfOfRowsInSection - 1) * spacingBetweenItems
            var neededHeightForChangingSection =
            totalHeightOfItems + heightOfBottomInsetOfSections + headerHeight
            
            if sectionIndex > 0 {
                neededHeightForChangingSection += heights[sectionIndex - 1]
            }
            
            heights.append(neededHeightForChangingSection)
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
    
    private func hideCategoriesReplacementView() {
        categoriesReplacementView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(-64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
    }
    
    private func checkScrollDirection(viewOffsetY: CGFloat) {
        if lastContentOffsetY > viewOffsetY {
            isScrollingUp = true
        } else {
            isScrollingUp = false
        }
    }
    
    private func pinCategoriesReplacementViewToTheTop() {
        categoriesReplacementView.snp.remakeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    private func makeNavigationBarVisible() {
        title = "Smile House Cafe"
        setupNavBarTitle()
        self.navigationController?.navigationBar.topItem?.setHidesBackButton(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        navigationItem.rightBarButtonItems = [likeBarButtonItem]
    }
    
    private func setupNavBarTitle() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppColor.heading.uiColor,
            .font: AppFont.semibold.s20()
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
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

// MARK: - SkeletonCollectionViewDataSource

extension RestaurantViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 5
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        return DishesCollectionViewCell.reuseID
    }
}
