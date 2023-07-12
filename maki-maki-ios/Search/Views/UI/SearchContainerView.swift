//
//  SearchContainerView.swift
//  maki-maki-ios
//
//  Created by Almat Alibekov on 12.06.2023.
//

import UIKit
import SnapKit

// MARK: - Search Container View protocol

protocol SearchContainerViewDelegate: AnyObject {
    func searchCompleted(word: String)
    func returnButtonTapped(lastWord: String)
    func clearButtonTapped(isTapped: Bool)
    func textFieldIsEmpty(state: Bool)
}

final class SearchContainerView: UIView {
    
    // MARK: - State
    
    private lazy var searchViewController: SearchV1ViewController = SearchV1ViewController()
    weak var delegate: SearchContainerViewDelegate?
    
    // MARK: - UI
    
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
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupSearchTextfieldFrame()
        searchViewController.delegate = self
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
}

// MARK: - Search Container View delegate methods

extension SearchContainerView: UITextFieldDelegate {
        
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let currentText = textField.text,
           let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            if !updatedText.isEmpty {
                delegate?.searchCompleted(word: updatedText)
                delegate?.textFieldIsEmpty(state: false)
            } else {
                delegate?.searchCompleted(word: "")
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            delegate?.returnButtonTapped(lastWord: text)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.clearButtonTapped(isTapped: true)
        return true
    }
}

extension SearchContainerView: SearchViewControllerDelegate {
    func recentSearchTapped(word: String) {
        searchBarTextField.text = word
    }
}
