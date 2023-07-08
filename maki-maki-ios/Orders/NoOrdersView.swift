//
//  NoOrdersView.swift
//  maki-maki-ios
//
//  Created by siberianarg on 09.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class NoOrdersView: UIView {
    
    // MARK: - UI
    
    private lazy var noOrdersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.no_orders.uiImage
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var noOrderslabel: UILabel = {
        let label = UILabel()
        label.text = "No Orders Yet!"
        label.textAlignment = .center
        label.textColor = AppColor.heading.uiColor
        label.font = AppFont.bold.s24()
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var proposalLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover and place your first order"
        label.textAlignment = .center
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s14()
        label.isSkeletonable = true
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
    
    // MARK: - Setup Views
    
    private func setupViews() {
        isSkeletonable = true
        // contentView.isSkeletonable = true
        [noOrdersImageView, noOrderslabel, proposalLabel].forEach { addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        noOrdersImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(111.41)
            make.height.equalTo(124)
        }
        
        noOrderslabel.snp.makeConstraints { make in
            make.top.equalTo(noOrdersImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        proposalLabel.snp.makeConstraints { make in
            make.top.equalTo(noOrderslabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 229, height: 194)
    }
}
