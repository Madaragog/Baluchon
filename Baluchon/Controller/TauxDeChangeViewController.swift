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
    var euroAmount: Double = 0.0

    func removeKeyboard() {
        euroTextField.resignFirstResponder()
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }
    func euroVerification() {
        if euroTextField.text != nil {
            if let euro = Double(euroTextField.text!) {
                euroAmount = euro
            }
        } else {
            self.alerteVC()
        }
    }
    @IBAction func tappedConvertButton() {
        if euroTextField.isFirstResponder == true {
            removeKeyboard()
        }
        ConverterService.getCurrency { (success, converter) in
            if success, let converter = converter {
                self.euroVerification()
                let dollarAmount = self.euroAmount * converter.dollardValues
                self.dollarTextField.text = "\(round(100*dollarAmount)/100)"
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
