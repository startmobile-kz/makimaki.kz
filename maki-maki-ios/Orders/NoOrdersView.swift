//
//  NoOrdersView.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 10.06.2023.
//

import UIKit
import SnapKit

class NoOrdersView: UIView {
    
    // MARK: - UI
    
    private lazy var noOrdersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.no_orders.uiImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var noOrderslabel: UILabel = {
        let label = UILabel()
        label.text = "No Orders Yet!"
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var proposalLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover and place your first order"
        label.textAlignment = .center
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        return label
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
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
