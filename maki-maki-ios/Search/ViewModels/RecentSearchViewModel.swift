//
//  RecentSearchViewModel.swift
//  maki-maki-ios
//
//  Created by Tami on 12.07.2023.
//

import Foundation

class RecentSearchViewModel {
    let recentSearch: String?
    
    init(history: History) {
        recentSearch = history.name
    }
}
