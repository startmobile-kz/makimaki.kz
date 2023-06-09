//
//  AccountListCell.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 04.06.2023.
//

import UIKit
import SnapKit

class AccountListCell: UITableViewCell {

    // MARK: - UI
    
    private lazy var listImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var listTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = AppFont.medium.s15()
        label.textColor = AppColor.heading.uiColor
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(logo: Logo) {
        listImageView.image = logo.image.uiImage
        listTitleLabel.text = logo.title
        arrowImageView.image = logo.arrow.uiImage
    }
    
    // MARK: - Set UI
    func setUI() {
        addSubview(listImageView)
        addSubview(listTitleLabel)
        addSubview(arrowImageView)
    }

    // MARK: - Setup Constraints
    func constraints() {
        listImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
        }
        
        listTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(listImageView.snp.centerY)
            make.leading.equalTo(listImageView.snp.trailing).offset(16)
        }

        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
