//
//  TauxDeChangeViewController.swift
//  Baluchon
//
//  Created by Cedric on 22/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class TauxDeChangeViewController: UIViewController {
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!
    @IBOutlet weak var newConversionButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var euroAmount: Double = 0.0
    var dollarValue: Double = 0.0

    func removeKeyboard() {
        euroTextField.resignFirstResponder()
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }
    func euroVerificationThenConversion() {
        if let euro = Double(euroTextField.text!.replacingOccurrences(of: ",", with: ".")) {
            euroAmount = euro
            let dollarAmount = self.euroAmount * self.dollarValue
            self.dollarTextField.text = "\(round(100*dollarAmount)/100)".replacingOccurrences(of: ".", with: ",")
        } else {
            self.alerteVC()
        }
    }
    func newConversionButtonAndActivityIndicatorManager(inProgress: Bool) {
        newConversionButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
    }
    @IBAction func tappedConvertButton() {
        if euroTextField.isFirstResponder == true {
            removeKeyboard()
        }
        self.newConversionButtonAndActivityIndicatorManager(inProgress: true)
        ConverterService.shared.getCurrency { (success, converter) in
            self.newConversionButtonAndActivityIndicatorManager(inProgress: false)
            if success && self.euroTextField.text != nil, let converter = converter {
                self.dollarValue = converter.dollarValue
                self.euroVerificationThenConversion()
            } else {
                self.alerteVC()
            }
        }
    }
    func alerteVC() {
        let alerteVC = UIAlertController(title: "Erreur",
                                         message: "Une erreur est survenue, veuillez réessayer !",
                                         preferredStyle: .alert)
        alerteVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alerteVC, animated: true, completion: nil)
    }
}
