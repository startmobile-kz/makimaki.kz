//
//  WelcomePagePresenter.swift
//  maki-maki-ios
//
//  Created by Ravil on 15.07.2023.
//

import Foundation
import UIKit

protocol WelcomePageView: AnyObject {
    func showSnackBar(message: String)
}

protocol WelcomePagePresenter {
    func continueButtonDidPress(phoneNumber: String?)
}

class WelcomePagePresenterImpl: WelcomePagePresenter {
    private weak var view: WelcomePageView?
    private weak var navigationController: UINavigationController?
    
    init(view: WelcomePageView, navigationController: UINavigationController?) {
        self.view = view
        self.navigationController = navigationController
    }
    
    func continueButtonDidPress(phoneNumber: String?) {
        guard let phoneNumber = phoneNumber else {
            view?.showSnackBar(message: "Phone number entered incorrectly.")
            return
        }
        
        if phoneNumber.isEmpty {
            view?.showSnackBar(message: "Please enter a phone number.")
            return
        }
        
        if phoneNumber.count != 18 {
            view?.showSnackBar(message: "Phone number entered incorrectly.")
            return
        }
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
        let formatedPhoneNumber = phoneNumber
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        
        let controller = VerificationViewController()
        navigationController?.pushViewController(controller, animated: true)
        
        let person = Person(uuid: deviceID, phone: formatedPhoneNumber)
        let service = WelcomePageService()
        service.authorizeWithAlamofire(with: person)
    }
}
