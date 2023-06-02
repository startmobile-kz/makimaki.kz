//
//  BasketTableViewCell.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 01.06.2023.
//

import UIKit
import SnapKit

class BasketTableViewCell: UITableViewCell {
    // MARK: - UI
    
    private lazy var orderImageView: UIImageView = {
        let image = UIImage(named: "order_Image.pdf")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var quantiiyLabel: UILabel = {
        let label = UILabel()
        label.text = "1  x"
        label.font = AppFont.medium.s15()
        return label
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pesto Tomato Pizza"
        label.numberOfLines = 0
        label.font = AppFont.medium.s15()
        return label
    }()
    
    private lazy var priceOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "$10.95"
        label.font = AppFont.reqular.s15()
        //label. = AppColor.paragraph
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
    }
}
