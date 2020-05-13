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
    @IBOutlet weak var milesToKmsConversionButton: UIButton!
    @IBOutlet weak var kmsToMilesConversionButton: UIButton!

    private let conversionService = DistanceConversionService()

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }
// Removes the keyboard if shown and shows the activity indicator while loading the result
// When the result is found the button unhides
// If any error occurs, a message is diplayed
    @IBAction func tappedMilesToKmsConversionButton() {
        removeKeyboard()
        self.milesToKmsButtonAndActivityIndicatorManager(inProgress: true)
        if let miles = Double(milesValue.text!.replacingOccurrences(of: ",", with: ".")) {
            let kilometers = conversionService.milesToKilometers(miles: miles)
            let kilometersRounded = round(1000*kilometers)/1000
            self.kilometersValue.text = "\(kilometersRounded)".replacingOccurrences(of: ".", with: ",")
            milesToKmsButtonAndActivityIndicatorManager(inProgress: false)
        } else {
            self.alerteVC()
            milesToKmsButtonAndActivityIndicatorManager(inProgress: false)
        }
    }
// Removes the keyboard if shown and shows the activity indicator while loading the result
// When the result is found the button unhides
// If any error occurs, a message is diplayed
    @IBAction func tappedKmsToMilesConversionButton(_ sender: UIButton) {
        removeKeyboard()
        self.kmsButtonAndActivityIndicatorManager(inProgress: true)
        if let kilometers = Double(kilometersValue.text!.replacingOccurrences(of: ",", with: ".")) {
            let miles = conversionService.kilometersToMiles(kilometers: kilometers)
            let milesRounded = round(1000*miles)/1000
            self.milesValue.text = "\(milesRounded)".replacingOccurrences(of: ".", with: ",")
            kmsButtonAndActivityIndicatorManager(inProgress: false)
        } else {
            self.alerteVC()
            kmsButtonAndActivityIndicatorManager(inProgress: false)
        }
    }
// Shows the milesToKms conversion button and hides the activityIndicator or the reverse depending on inProgress.
    private func milesToKmsButtonAndActivityIndicatorManager(inProgress: Bool) {
        milesToKmsConversionButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
    }
// Shows the kmsToMiles conversion button and hides the activityIndicator or the reverse depending on inProgress.
    private func kmsButtonAndActivityIndicatorManager(inProgress: Bool) {
        kmsToMilesConversionButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
    }
// Removes the keyboard if displayed
    private func removeKeyboard() {
        if milesValue.isFirstResponder == true {
            milesValue.resignFirstResponder()
        } else if kilometersValue.isFirstResponder == true {
            kilometersValue.resignFirstResponder()
        }
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
