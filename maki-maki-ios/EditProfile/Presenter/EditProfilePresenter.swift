//
//  EditProfilePresenter.swift
//  maki-maki-ios
//
//  Created by Ravil on 12.07.2023.
//

import Foundation

protocol EditProfilePresenterDelegate: AnyObject {
    func profileDidUpdate(user: User)
}

class EditProfilePresenter {
    
    weak var view: EditProfileView?
    weak var delegate: EditProfilePresenterDelegate?
    
    init(view: EditProfileView) {
        self.view = view
        self.view?.delegate = self
    }
    
    func viewDidLoad() {
        // Perform any setup needed when the view loads
    }
}

extension EditProfilePresenter: EditProfileViewDelegate {
    func saveButtonDidPress(with user: User) {
        delegate?.profileDidUpdate(user: user)
    }
}
