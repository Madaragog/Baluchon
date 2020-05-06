//
//  ConversionViewController.swift
//  Baluchon
//
//  Created by Cedric on 02/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController {

    @IBOutlet weak var milesValue: UITextField!
    @IBOutlet weak var kilometersValue: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newConversionButton: UIButton!

    private let conversionService = DistanceConversionService()

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }
// Removes the keyboard if shown and shows the activity indicator while loading the result
// When the result is found the button unhides
// If any error occurs, a message is diplayed
    @IBAction func conversionButton() {
        if milesValue.isFirstResponder == true {
            removeKeyboard()
        }
        self.newConversionButtonAndActivityIndicatorManager(inProgress: true)
        if let miles = Double(milesValue.text!.replacingOccurrences(of: ",", with: ".")) {
            let kilometers = conversionService.milesToKilometers(miles: miles)
            let kilometersRounded = round(1000*kilometers)/1000
            self.kilometersValue.text = "\(kilometersRounded)".replacingOccurrences(of: ".", with: ",")
            newConversionButtonAndActivityIndicatorManager(inProgress: false)
        } else {
            self.alerteVC()
            newConversionButtonAndActivityIndicatorManager(inProgress: false)
        }
    }
    // Shows the conversion button and hides the activityIndicator or the reverse depending on inProgress.
    private func newConversionButtonAndActivityIndicatorManager(inProgress: Bool) {
        newConversionButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
    }
    // Removes the keyboard if displayed
    private func removeKeyboard() {
        milesValue.resignFirstResponder()
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
