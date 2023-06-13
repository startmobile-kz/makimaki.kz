//
//  RecentSearchesTableViewCell.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 10.06.2023.
//

import UIKit
import SnapKit

final class RecentSearchesTableViewCell: UITableViewCell {

    static let reuseID = String(describing: RecentSearchesTableViewCell.self)
    
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
        let stackView = UIStackView(arrangedSubviews: [clockImage, recentSearchLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 11
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
        contentView.addSubview(recentInfoStackView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        recentInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(13)
            make.leading.equalTo(16)
            make.width.equalTo(116)
            make.centerY.equalToSuperview()
        }
        
        clockImage.snp.makeConstraints { make in
            make.height.width.equalTo(14)
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
    }
}
