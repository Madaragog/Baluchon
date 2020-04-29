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

    private let convertService = ConverterService()

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }

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
        }
    }

    private func newConversionButtonAndActivityIndicatorManager(inProgress: Bool) {
        newConversionButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
    }

    private func removeKeyboard() {
        euroTextField.resignFirstResponder()
    }

    private func alerteVC() {
        let alerteVC = UIAlertController(title: "Erreur",
                                         message: "Une erreur est survenue, veuillez réessayer !",
                                         preferredStyle: .alert)
        alerteVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alerteVC, animated: true, completion: nil)
    }
}
