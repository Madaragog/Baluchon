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

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        euroTextField.resignFirstResponder()
    }

    @IBAction func tappedConvertButton() {
        if euroTextField.isFirstResponder == true {
            euroTextField.resignFirstResponder()
        }
        ConverterService.getCurrency()
    }
}
