//
//  DishCell.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 12.06.2023.
//

import UIKit
import SnapKit

class DishCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseID = String(describing: DishCell.self)
    
    // MARK: - UI
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        
    }
}
