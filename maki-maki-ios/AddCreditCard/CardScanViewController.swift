//
//  ScanViewController.swift
//  maki-maki-ios
//
//  Created by Darkhan on 01.07.2023.
//

import UIKit
import CardIO

class CardScanViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCardScanning()
    }
    
    func startCardScanning() {
        let cardIOViewController = CardIOPaymentViewController(paymentDelegate: self)
        cardIOViewController!.modalPresentationStyle = .fullScreen
        cardIOViewController!.scanExpiry = true 
        cardIOViewController!.collectCVV = true
        present(cardIOViewController!, animated: true, completion: nil)
    }
    
    // MARK: - CardIOPaymentViewControllerDelegate
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo?, in paymentViewController: CardIOPaymentViewController) {
        if let cardInfo = cardInfo {
            let cardNumber = cardInfo.cardNumber ?? ""
            let cardExpiration = "\(cardInfo.expiryMonth)/\(cardInfo.expiryYear)"
            paymentViewController.dismiss(animated: true, completion: nil)
        }
    }
}
