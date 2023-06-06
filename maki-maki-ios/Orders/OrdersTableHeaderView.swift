//
//  OrdersTableHeaderView.swift
//  maki-maki-ios
//
//  Created by siberianarg on 06.06.2023.
//

import UIKit

class OrdersTableHeaderView: UITableViewHeaderFooterView {

    static let identifier = String(describing: OrdersTableHeaderView.self)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
