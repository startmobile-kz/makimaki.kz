//
//  SearchBar.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 12.06.2023.
//

import UIKit
import SnapKit

protocol SearchBarDelegate: AnyObject {
    
    func searchDelegate(word: String)
}

final class SearchBar: UIView, UITextFieldDelegate {
    
    var delegate: SearchBarDelegate?

    // MARK: - UI Custom searchBar properties
    static let reuseID = String(describing: SearchBar.self)
    
    var dataToUseInSearch: String = ""
    
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
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = AppColor.border.cgColor
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupSearchTextfieldFrame()
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
    
    // MARK: - Search textfield frame setup
    private func setupSearchTextfieldFrame() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: self.frame.height))
        searchBarTextField.leftView = paddingView
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        var finalString = ""
        if range.length > 0 {
            finalString = "\(textField.text!.dropLast())"
        } else {
            
            finalString = "\(textField.text! + string)"
        }
        print(finalString)
        dataToUseInSearch = finalString
        self.delegate?.searchDelegate(word: finalString)
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print(dataToUseInSearch)
//    }
}
