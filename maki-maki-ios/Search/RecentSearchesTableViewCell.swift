//
//  RecentSearchesTableViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 10.06.2023.
//

import UIKit
import SnapKit

class RecentSearchesTableViewCell: UITableViewCell {

    // MARK: - UI
    private lazy var clockImage: UIImageView = {
        let image = UIImageView()
        image.image = AppImage.clock.uiImage
        return image
        
    }()
    
    private lazy var recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Pizza"
        label.textColor = AppColor.paragraph.uiColor
        label.font = AppFont.reqular.s15()
        return label
        
    }()
    
    private lazy var recentInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: - Lifecycle
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
        let subviews = [clockImage, recentSearchLabel]
        recentInfoStackView.addSubviews(subviews)
        contentView.addSubview(recentInfoStackView)
        
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        recentInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(243)
            make.height.equalTo(40)
            make.top.equalTo(13)
            make.bottom.equalTo(-13)
        }
        
        clockImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.leading.equalTo(clockImage.snp.trailing).offset(11)
            make.centerY.equalToSuperview()
        }
    }
}
