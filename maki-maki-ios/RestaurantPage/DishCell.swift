//
//  DishCell.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 12.06.2023.
//

import UIKit
import SnapKit

final class DishCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseID = String(describing: DishCell.self)
    
    // MARK: - UI
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
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
        addSubview(view)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
