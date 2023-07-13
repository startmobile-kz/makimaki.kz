//
//  OrdersSkeletonCell.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 13.07.2023.
//

import UIKit
import SnapKit
import SkeletonView

class OrdersSkeletonCell: UITableViewCell {
    
    static let reuseID = String(describing: OrdersSkeletonCell.self)
    
    // MARK: - UI
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        
    }
    
    private func setupLayout() {
        
    }
}
