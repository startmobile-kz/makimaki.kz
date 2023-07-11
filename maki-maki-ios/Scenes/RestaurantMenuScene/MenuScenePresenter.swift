//
//  MenuScenePresenter.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 11.07.2023.
//

import Foundation

protocol MenuScenePresentationLogic {
    func presentMenu(response: MenuSceneModels.Response)
    
    func calculateNeededHeight(
        sectionCount: Int,
        dividedProducts: [Int: [RestaurantProduct]]
    )
}

final class MenuScenePresenter: MenuScenePresentationLogic {
    
    weak var viewController: MenuSceneDisplayLogic?
    
    // MARK: State
    
    func presentMenu(response: MenuSceneModels.Response) {
        let viewModel = MenuSceneModels.ViewModel(
            categoriesAndNames: response.groupedProducts.categoriesAndNames,
            dividedProducts: response.groupedProducts.dividedProducts)
        viewController?.displayMenu(viewModel: viewModel)
    }
    
    func calculateNeededHeight(
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
        viewController?.getNeededHeight(heights: heights)
    }
}
