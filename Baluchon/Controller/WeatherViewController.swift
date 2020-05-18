//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Cedric on 15/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var tempNYCText: UITextField!
    @IBOutlet weak var desrciptionNYCText: UITextField!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tempRennesText: UITextField!
    @IBOutlet weak var descriptionRennesText: UITextField!

    private let weatherService = WeatherService()

    override func viewDidLoad() {
        displayWeather()
    }
    @IBAction func tappedRefreshButton(_ sender: UIButton) {
        displayWeather()
    }
// Hides the refresh button and shows the activityIndicator while getting the meteo
// Displays a message if an error occurs
// Eventually the refreshButton is shown and the activityIndicator is hidden
    private func displayWeather() {
        refreshButtonAndActivityIndicatorManager(inProgress: true)
        weatherService.getNYCWeather { (tempNYC, descriptionNYC) in
            if let tempNYC = tempNYC, let descriptionNYC = descriptionNYC {
                let tempNYCRounded = round(10*tempNYC)/10
                self.tempNYCText.text = "\(tempNYCRounded)".replacingOccurrences(of: ".", with: ",")
                self.desrciptionNYCText.text = "\(descriptionNYC)"
                self.weatherService.getRennesWeather { (tempRennes, descriptionRennes) in
                    if let tempRennes = tempRennes, let descriptionRennes = descriptionRennes {
                        let tempRennesRounded = round(10*tempRennes)/10
                        self.tempRennesText.text = "\(tempRennesRounded)".replacingOccurrences(of: ".", with: ",")
                        self.descriptionRennesText.text = "\(descriptionRennes)"
                    }
                }
            } else {
                self.alerteVC()
            }
        }
        refreshButtonAndActivityIndicatorManager(inProgress: false)
    }
// Shows the translation button and hides the activityIndicator or the reverse depending on the progress.
    private func refreshButtonAndActivityIndicatorManager(inProgress: Bool) {
        refreshButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
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
