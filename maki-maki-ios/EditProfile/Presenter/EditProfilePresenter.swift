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
    }
    
    func viewDidLoad() {
        
    }
}
