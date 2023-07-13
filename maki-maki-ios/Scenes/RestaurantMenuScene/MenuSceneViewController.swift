//
//  RestaurantMenuVIPController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import UIKit
import SnapKit
import SkeletonView

// swiftlint:disable all

protocol MenuSceneDisplayLogic: NSObject {
    func displayMenu(viewModel: MenuSceneModels.ViewModel)
    func makeNavigationBarVisible()
    func pinCategoriesReplacementViewToTheTop()
    func bringReplacementMenuToFront()
    func callLayoutIfNeeded()
    func hideCategoriesReplacementView()
    func setupNavigationBar()
    func changeContentOffset(neededHeight: Double)
    func setCategories(categories: [Category])
}

final class MenuSceneViewController: UIViewController, MenuSceneDisplayLogic {
    
    // MARK: - VIP Part
    
    var interactor: MenuSceneBusinessLogic?
    var router: (MenuSceneRoutingLogic & MenuSceneDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupArchitecture()
    }
    
    // MARK: - SetupArchitecture
    
    private func setupArchitecture() {
        let viewController = self
        let interactor = MenuSceneInteractor()
        let presenter = MenuScenePresenter()
        let router = MenuSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayMenu(viewModel: MenuSceneModels.ViewModel) {
        self.categoriesAndNames = viewModel.categoriesAndNames
        self.productsByCategoryMap = viewModel.dividedProducts
        self.isLoaded = true
    }
    
    private func fetchMenu() {
        let request = MenuSceneModels.Request()
        interactor?.fetchProducts(request: request)
    }
    
    // MARK: - State

    public var selectedProducts: [RestaurantProduct] = []
    private var categories: [Category] = []
    private var categoriesAndNames: [Int: String] = [:]
    private var productsByCategoryMap: [Int: [RestaurantProduct]] = [:]
    private var isLoaded = false {
        didSet {
            hideSkeletons()
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI
    
    private lazy var categoriesReplacementView: CategoryMenuView = {
        let view = CategoryMenuView(type: .stickyHeader)
        return view
    }()
    
    private lazy var likeBarButtonItem: UIBarButtonItem = {
        let likeImage = AppImage.like_black.uiImage
        let item = UIBarButtonItem(image: .none, style: .plain, target: nil, action: nil)
        item.tintColor = .black
        return item
    }()
    
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
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.reuseID
        )
        collectionView.register(
            ProductSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProductSectionHeaderView.reuseId
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.bounces = false
        collectionView.isSkeletonable = true
        collectionView.isUserInteractionDisabledWhenSkeletonIsActive = false
        return collectionView
    }()
    
    private lazy var viewCartContainerView: ViewCartContainer = {
        let view = ViewCartContainer()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openBasket))
        view.addGestureRecognizer(tap)
        view.isSkeletonable = true
        return view
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        showSkeletonAnimation()
        fetchMenu()
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

    // MARK: - SetupNavigationBar
    
    func setupNavigationBar() {
        title = ""
        navigationItem.rightBarButtonItems = []
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // MARK: - SetupSkeletons
    
    private func showSkeletonAnimation() {
        collectionView.prepareSkeleton { _ in
            self.collectionView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
        }
        
        self.viewCartContainerView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
    }
    
    private func hideSkeletons() {
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton(transition: .crossDissolve(0.25))
        viewCartContainerView.stopSkeletonAnimation()
        viewCartContainerView.hideSkeleton(transition: .crossDissolve(0.25))
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
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
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
            if let self = self {
                switch sectionIndex {
                case 0:
                    section.boundarySupplementaryItems = [self.supplementaryMainHeaderItem()]
                default:
                    section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                }
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
        let safeTopInsetHeight = view.safeAreaLayoutGuide.layoutFrame.minY
        
        interactor?.sendScrollStateToPresenter(
            scrollView: scrollView,
            safeAreaYCoordinate: safeTopInsetHeight
        )
    }
    
    func bringReplacementMenuToFront() {
        categoriesReplacementView.bringSubviewToFront(self.view)
    }
    
    func callLayoutIfNeeded() {
        view.layoutIfNeeded()
    }
    
    func changeContentOffset(neededHeight: Double) {
        collectionView.setContentOffset(
            CGPoint(x: 0, y: neededHeight),
            animated: true
        )
    }
    
    func setCategories(categories: [Category]) {
        categoriesReplacementView.configureCategories(categories: categories)
        self.categories = categories
        collectionView.reloadData()
//        hideSkeletons()
    }
    
    // MARK: - ActionsneededHeight: Double
    
    @objc private func openBasket() {
        let basketSceneViewController = BasketSceneViewController()
        basketSceneViewController.router?.dataStore?.selectedProducts = selectedProducts
        router?.navigateToBasket(destination: basketSceneViewController)
    }
    
    func hideCategoriesReplacementView() {
        categoriesReplacementView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(-64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
    }
    
    func pinCategoriesReplacementViewToTheTop() {
        categoriesReplacementView.snp.remakeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    func makeNavigationBarVisible() {
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

// MARK: - DishViewControllerDelegate methods

extension MenuSceneViewController: DishViewControllerDelegate {
    func addToBasket(dish: RestaurantProduct) {
        collectionView.reloadData()
         
        productsByCategoryMap.values.forEach { products in
            selectedProducts.append(contentsOf: products.filter({ product in
                return product.isSelected && !selectedProducts.contains(where: {$0.id == product.id})
            }))
        }
        
        viewCartContainerView.setupData(products: selectedProducts)
    }
}

// MARK: - UICollectionViewDelegate methods

extension MenuSceneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isLoaded {
            return
        }
        
        let dishViewController = DishViewController()
        dishViewController.dish = productsByCategoryMap[indexPath.section + 1]?[indexPath.row]
        dishViewController.delegate = self
        present(dishViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource methods

extension MenuSceneViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoriesAndNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsByCategoryMap[section + 1]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.reuseID,
            for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Could not cast to DishesCollectionViewCell")
        }
        guard let product = productsByCategoryMap[indexPath.section + 1]?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.setupData(product: product)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProductSectionHeaderView.reuseId,
                for: indexPath
            ) as? ProductSectionHeaderView else {
                fatalError("Could not cast to DishSectionHeaderView")
            }
            let sectionID = indexPath.section + 1
            switch sectionID {
            case 1:
                guard let mainHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: RestaurantHeaderView.reuseID,
                    for: indexPath
                ) as? RestaurantHeaderView else {
                    fatalError("Could not cast to RestaurantHeaderView")
                }
                mainHeader.setCategories(categories: categories)
                return mainHeader
            default :
                sectionHeader.setSectionHeaderTitle(title: categoriesAndNames[sectionID] ?? "")
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }

}

// MARK: - SkeletonCollectionViewDataSource

extension MenuSceneViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView,numberOfItemsInSection section: Int)
    -> Int {
        return 8
    }
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        return ProductCollectionViewCell.reuseID
    }
}
// swiftlint:enable all