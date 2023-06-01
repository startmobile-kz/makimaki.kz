//
//  PromoBannerCollectionViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 01.06.2023.
//

import UIKit
import SnapKit

class PromoBannerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "PromoCell"
    
    // MARK: -UI
    
    private lazy var promoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Promo1")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let subviews = [promoImageView, ]
        subviews.forEach( { contentView.addSubview($0) } )
        
    }
    
    private func setupConstraints() {
        
        promoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}
