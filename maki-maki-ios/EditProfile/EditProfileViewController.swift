//
//  EditProfileViewController.swift
//  maki-maki-ios
//
//  Created by Ravil on 30.05.2023.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    private var presenter: EditProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editProfileView = EditProfileView()
        view = editProfileView
        
        presenter = EditProfilePresenter(view: editProfileView)
        presenter?.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Profile"
    }
}
