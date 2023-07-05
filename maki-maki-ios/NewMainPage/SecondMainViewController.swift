//
//  SecondMainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 30.06.2023.
//

import UIKit
import SnapKit

// swiftlint:disable all
class SecondMainViewController: UIViewController {
    
    // MARK: - State
    
    private var service = RestaurantProductService()
    private let sections: [NewMainPageSectionTypes] = [.promos, .products]
    private var categoriesAndNames: [Int: String] = [:]
    private var productsByCategoryMap: [Int: [RestaurantProduct]] = [:]
    public var selectedProducts: [RestaurantProduct] = []
    private var lastContentOffsetY: CGFloat = 0
    private var isScrollingUp = false
    private let deliveryHeaderHeight: Double  = 43.5
    private let promoSectionHeight: Double = 210
    private let categoryMenuHeight: Double = 40
    private let categoryMenuHeightWithBottomPadding: Double = 60
    private var isScrollToSectionCalled = false
    private var currentSection = 0
    private var heights: [Double] = []
    static let notificationName = Notification.Name("scrolledToSection")
    private var isLoaded = false {
        didSet {
            calculateAllSectionHeights()
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI
    
    private lazy var categoriesReplacementView: CategoryMenuView = {
        let view = CategoryMenuView(type: .stickyHeader)
        return view
    }()
    
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
    
    private lazy var viewCartContainerView: ViewCartContainer = {
        let view = ViewCartContainer()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openBasket))
        view.addGestureRecognizer(tap)
        view.isSkeletonable = true
        return view
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNotificationObservers()
        fetchCategoriesWithProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavBar()
    }
    
    // MARK: - SetupView
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews(
            [deliveryHeaderView, separatorView, collectionView, categoriesReplacementView, viewCartContainerView]
        )
        setupViewCartAppearance()
    }
    
    // MARK: - SetupLayout
    
    private func setupConstraints() {
        categoriesReplacementView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-60)
            make.leading.trailing.equalToSuperview()
        }
        
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
        
        viewCartContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(85)
        }
        self.view.layoutIfNeeded()
    }
    
    // MARK: - SetupNavigationBar
    
    private func hideNavBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func showNavBar() {
        self.navigationController?.isNavigationBarHidden = false
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
    
    // MARK: - SetupNotificationObservers
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(scrollToSection),
            name: CategoryMenuView.notificationName,
            object: nil
        )
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
                self?.isLoaded = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func pinCategoriesReplacementViewToTheTop() {
        categoriesReplacementView.snp.remakeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        separatorView.isHidden = true
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
        heights = []
        let itemHeight: Double = 242
        let spacingBetweenItems: Double = 14
        let heightOfBottomInsetOfSections: Double = 16
        let heightForPinningHeader = promoSectionHeight + categoryMenuHeight
        for sectionIndex in 0..<categoriesAndNames.count {
            let headerHeight: Double = (sectionIndex == 0) ? heightForPinningHeader : 36
            let numOfProducts = productsByCategoryMap[sectionIndex + 1]?.count ?? 0
            let numfOfRowsInSection = ceil(Double(numOfProducts) / 2)
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
    
    private func setupViewCartAppearance() {
        viewCartContainerView.isHidden = selectedProducts.isEmpty
    }
    
    // MARK: - Actions
    
    @objc func scrollToSection(_ notification: Notification) {
        let sectionIndex = notification.userInfo?["sectionIndex"] as? Int ?? 0
        let sectionTopContentOffset: Double = 4
        let additionalOffset = sectionTopContentOffset * Double(sectionIndex)
        isScrollToSectionCalled = true
        if currentSection != sectionIndex {
            var neededHeight: Double = 0
            if sectionIndex == 0 {
                neededHeight = 0
            } else {
                neededHeight = heights[sectionIndex - 1] - categoryMenuHeight
            }
            collectionView.setContentOffset(
                CGPoint(x: 0, y: neededHeight + additionalOffset),
                animated: true
            )
            currentSection = sectionIndex
            sendNotification(section: sectionIndex)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isScrollToSectionCalled = false
        }
    }
    
    @objc private func openBasket() {
        let basketViewController = BasketViewController()
        basketViewController.selectedDishes = selectedProducts
        self.navigationController?.pushViewController(basketViewController, animated: true)
    }
}

extension SecondMainViewController: DeliveryHeaderViewDelegate {
    func viewWasTapped() {
        let controller = ManageAdressesViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isLoaded {
            return
        }
        
        if indexPath.section > 0 {
            let dishViewController = DishViewController()
            dishViewController.dish = productsByCategoryMap[indexPath.section]?[indexPath.row]
            dishViewController.delegate = self
            present(dishViewController, animated: true)
        }
    }
}

// MARK: - UICollectionView Delegate methods

extension SecondMainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLoaded {
            
            if !isScrollToSectionCalled {
                let yOffset = scrollView.contentOffset.y
                let heightOfOneRowOfItems: Double = 242
                let multiplier: Double = productsByCategoryMap[currentSection]?.count ?? 0 > 2 ? 2 : 1
                if yOffset >= heights[currentSection] - categoryMenuHeight {
                    currentSection += 1
                    sendNotification(section: currentSection)
                } else if
                    currentSection > 0 &&
                    yOffset < heights[currentSection - 1] - heightOfOneRowOfItems * multiplier {
                    currentSection -= 1
                    sendNotification(section: currentSection)
                }
            }
            
            let heightForPinningHeader = promoSectionHeight + categoryMenuHeight
            var sticked = false
            checkScrollDirection(viewOffsetY: scrollView.contentOffset.y)
            if scrollView.contentOffset.y > heightForPinningHeader {
                if !sticked {
                    self.pinCategoriesReplacementViewToTheTop()
                    self.categoriesReplacementView.bringSubviewToFront(self.view)
                    self.view.layoutIfNeeded()
                    sticked = true
                }
            }
            if isScrollingUp {
                if scrollView.contentOffset.y < heightForPinningHeader {
                    hideCategoriesReplacementView()
                    separatorView.isHidden = false
                    view.layoutIfNeeded()
                    sticked = false
                }
            }
            lastContentOffsetY = scrollView.contentOffset.y
        }
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
}

// MARK: - UICollectionView DataSource methods

extension SecondMainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count + 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

extension SecondMainViewController: DishViewControllerDelegate {
    func addToBasket(dish: RestaurantProduct) {
        collectionView.reloadData()
         
        productsByCategoryMap.values.forEach { products in
            print(products.description)
            selectedProducts.append(contentsOf: products.filter({ product in
                return product.isSelected && !selectedProducts.contains(where: {$0.id == product.id})
            }))
        }
        
        setupViewCartAppearance()
        viewCartContainerView.setupData(products: selectedProducts)
    }
}
// swiftlint:enable all
