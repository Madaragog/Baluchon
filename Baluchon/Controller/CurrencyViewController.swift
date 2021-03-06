//
//  TauxDeChangeViewController.swift
//  Baluchon
//
//  Created by Cedric on 22/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!
    @IBOutlet weak var newConversionButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
// Creates an instance of ConverterService.
    private let convertService = CurrencyConversionService()

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }
// Removes keyboard if shown and hides the button while converting euro to dollars by calling the convertToUsd func.
// Displays an alerte if something goes wrong.
    @IBAction func tappedConvertButton() {
        if euroTextField.isFirstResponder == true {
            removeKeyboard()
        }
        self.newConversionButtonAndActivityIndicatorManager(inProgress: true)
        if let euro = Double(euroTextField.text!.replacingOccurrences(of: ",", with: ".")) {
            convertService.convertToUsd(euro: euro) { (usd) in
                self.newConversionButtonAndActivityIndicatorManager(inProgress: false)
                if let usd = usd {
                    let usdRounded = round(100*usd)/100
                    self.dollarTextField.text = "\(usdRounded)".replacingOccurrences(of: ".", with: ",")
                } else {
                    self.alerteVC()
                }
            }
        } else {
            self.alerteVC()
            self.newConversionButtonAndActivityIndicatorManager(inProgress: false)
        }
    }
// Shows the conversion button and hides the activityIndicator or the reverse depending on the progress.
    private func newConversionButtonAndActivityIndicatorManager(inProgress: Bool) {
        newConversionButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
    }
// Removes the keyboard if displayed
    private func removeKeyboard() {
        euroTextField.resignFirstResponder()
    }
// Shows an alert
    private func alerteVC() {
        let alerteVC = UIAlertController(title: "Erreur",
                                         message: "Une erreur est survenue, veuillez réessayer !",
                                         preferredStyle: .alert)
        alerteVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alerteVC, animated: true, completion: nil)
    }
}
