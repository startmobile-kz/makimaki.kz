//
//  ScanViewController.swift
//  maki-maki-ios
//
//  Created by Darkhan on 30.06.2023.
//

import UIKit
import CardIO

class ReadyMadeViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    @IBOutlet weak var labelResults: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startScanningButtonClicked(sender: UIButton) {
        // Do your scannner implementation here
        /// Create CardIOPaymentViewController object with paymentDelegate to self.
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        
        /// Set to true if you need to collect the cardholder name. Defaults to false.
        cardIOVC.collectCardholderName = true
        
        /// Hide the PayPal or card.io logo in the scan view. Defaults to false.
        cardIOVC.hideCardIOLogo = true
        
        /// Set the guide color, Defaults to nil; if nil, will use card.io green.
        cardIOVC.guideColor = UIColor.redColor()
        
        /// Set to false if you don't need to collect the CVV from the user. Defaults to true.
        cardIOVC.collectCVV = true
        
        
        /// A custom view that will be overlaid atop the entire scan view. Defaults to nil.
        //        let overlay = UIView(frame: cardIOVC.view.frame)
        //        overlay.backgroundColor = UIColor.blueColor()
        //        overlay.alpha = 0.3
        //        cardIOVC.scanOverlayView = overlay
        
        /// Present Card Scanner View modally.
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    //MARK :- CardIOPaymentViewControllerDelegate
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        labelResults.text = "User has canceled the scanner."
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo?, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Cardholders Name: %@ \n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.cardholderName, info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            labelResults.text = str as String
        }
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
