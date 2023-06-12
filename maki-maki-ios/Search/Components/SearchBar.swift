//
//  SearchBar.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 12.06.2023.
//

import Foundation
import UIKit
import SnapKit

class SearchBar: UIView {

    // MARK: - UI Custom searchBar properties
    static let identifier: String = "[SearchBar]"
    
    private lazy var searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.search_icon.uiImage
        return imageView
    }()
    
    private lazy var searchBarTextField: UITextField = {
       
        let textField = UITextField()
        textField.placeholder = "Search for a dish"
        textField.backgroundColor = AppColor.grey100.uiColor
        textField.layer.cornerRadius = 14
        textField.font = AppFont.reqular.s14()
        textField.textColor = AppColor.heading.uiColor
        let paddingView = UIView(frame: CGRectMake(0, 0, 48, self.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = AppColor.border.cgColor
        return textField
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("did not instanstiate coder")
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        searchBarTextField.addSubview(searchIconImageView)
        self.addSubview(searchBarTextField)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        searchBarTextField.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        searchIconImageView.snp.makeConstraints { make in
            make.leading.top.equalTo(16.25)
            make.height.width.equalTo(15.5)
        }
    }
}
