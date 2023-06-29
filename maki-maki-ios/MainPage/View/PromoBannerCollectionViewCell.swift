//
//  PromoBannerCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 01.06.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class PromoBannerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: PromoBannerCollectionViewCell.self)
    
    // MARK: - UI
    private lazy var promoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        return imageView
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
        contentView.isSkeletonable = true
        isSkeletonable = true
        let subviews = [promoImageView]
        subviews.forEach({contentView.addSubview($0)})
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        promoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
