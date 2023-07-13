//
//  MenuScenePresenter.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation
import UIKit

protocol MenuScenePresentationLogic {
    func presentMenu(response: MenuSceneModels.Response)
    
    func scrollViewScrolled(
        scrollView: UIScrollView,
        safeAreaYCoordinate: CGFloat,
        heights: [Double]
    )
}

final class MenuScenePresenter: MenuScenePresentationLogic {
    
    weak var viewController: MenuSceneDisplayLogic?
    
    // MARK: State
    
    private var isLoaded = false
    private var lastContentOffsetY: CGFloat = 0
    private var isScrollingUp = false
    private let initialHeaderHeight: CGFloat = 318
    private let spacingBetweenHeaderAndSection: CGFloat = 32
    private let categoryMenuHeight: Double = 60
    private var isScrollToSectionCalled = false
    private var currentSection = 0
    private var heights: [Double] = []
    
    // MARK: - Lifecycle
    
    init() {
        setupNotificationObservers()
    }
    
    func presentMenu(response: MenuSceneModels.Response) {
        let categories = response.groupedProducts.categoriesAndNames
        let products = response.groupedProducts.dividedProducts
        let viewModel = MenuSceneModels.ViewModel(
            categoriesAndNames: categories,
            dividedProducts: products)
        isLoaded = true
        calculateNeededHeight(
            sectionCount: categories.count,
            dividedProducts: products
        )
        viewController?.displayMenu(viewModel: viewModel)
    }
    
    private func calculateNeededHeight(
        sectionCount: Int,
        dividedProducts: [Int: [RestaurantProduct]]
    ) {
        var heights = [Double]()
        let itemHeight: Double = 242
        let spacingBetweenItems: Double = 14
        let heightOfBottomInsetOfSections: Double = 16
        
        for sectionIndex in 0..<sectionCount {
            let headerHeight: Double = (sectionIndex == 0) ? 342 : 36
            let numOfProducts = dividedProducts[sectionIndex + 1]?.count ?? 0
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
        
        self.heights = heights
    }
    
    func scrollViewScrolled(scrollView: UIScrollView, safeAreaYCoordinate: CGFloat, heights: [Double]) {
        if isLoaded {
            if !isScrollToSectionCalled {
                let yOffset = scrollView.contentOffset.y
                let heightOfOneRowOfItems: Double = 242
                let safeTopInsetHeight = safeAreaYCoordinate
                if yOffset >= heights[currentSection] - safeTopInsetHeight - categoryMenuHeight {
                    currentSection += 1
                    sendNotification(section: currentSection)
                } else if
                    currentSection > 0 && yOffset < heights[currentSection - 1] - heightOfOneRowOfItems * 2 {
                    currentSection -= 1
                    sendNotification(section: currentSection)
                }
            }
            
            var sticked = false
            checkScrollDirection(viewOffsetY: scrollView.contentOffset.y)
            if scrollView.contentOffset.y > initialHeaderHeight {
                if !sticked {
                    UIView.animate(withDuration: 0.1) { [weak self] in
                        guard let self = self else {
                            return
                        }
                        viewController?.makeNavigationBarVisible()
                        viewController?.pinCategoriesReplacementViewToTheTop()
                        viewController?.bringReplacementMenuToFront()
                        viewController?.callLayoutIfNeeded()
                        sticked = true
                    }
                }
            }
            if isScrollingUp {
                if scrollView.contentOffset.y < initialHeaderHeight {
                    viewController?.hideCategoriesReplacementView()
                    viewController?.setupNavigationBar()
                    viewController?.callLayoutIfNeeded()
                    sticked = false
                }
            }
            lastContentOffsetY = scrollView.contentOffset.y
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
    
    private func checkScrollDirection(viewOffsetY: CGFloat) {
        if lastContentOffsetY > viewOffsetY {
            isScrollingUp = true
        } else {
            isScrollingUp = false
        }
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(scrollToSection),
            name: CategoryMenuView.notificationName,
            object: nil
        )
    }
    
    @objc func scrollToSection(_ notification: Notification) {
        let sectionIndex = notification.userInfo?["sectionIndex"] as? Int ?? 0
        isScrollToSectionCalled = true
        if currentSection != sectionIndex {
            var neededHeight: Double = 0
            if sectionIndex == 0 {
                neededHeight = 0
            } else {
                neededHeight = heights[sectionIndex - 1] - categoryMenuHeight
            }
            viewController?.changeContentOffset(neededHeight: neededHeight)
            currentSection = sectionIndex
            sendNotification(section: sectionIndex)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isScrollToSectionCalled = false
        }
    }
}
