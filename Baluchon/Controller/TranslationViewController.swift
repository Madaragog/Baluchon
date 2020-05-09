//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by Cedric on 05/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var translationButton: UIButton!
    @IBOutlet weak var textTranslated: UITextView!

    private let translationService = TranslationService()

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }
// Removes keyboard if shown and hides the button while translating by calling the getTranslation func.
// Displays an alerte if something goes wrong.
    @IBAction func tappedTranslationButton() {
        if textToTranslate.isFirstResponder == true {
            removeKeyboard()
        }
        self.translationButtonAndActivityIndicatorManager(inProgress: true)
        if textToTranslate.text.isEmpty == false, let textToTranslate = self.textToTranslate.text {
            translationService.getTranslation(text: textToTranslate) { (translatedText) in
                self.translationButtonAndActivityIndicatorManager(inProgress: false)
                if let translatedText = translatedText {
                    self.textTranslated.text = "\(translatedText)"
                } else {
                    self.alerteVC()
                    self.translationButtonAndActivityIndicatorManager(inProgress: false)
                }
            }
        } else {
            self.alerteVC()
            self.translationButtonAndActivityIndicatorManager(inProgress: false)
        }
    }
// Shows the translation button and hides the activityIndicator or the reverse depending on the progress.
    private func translationButtonAndActivityIndicatorManager(inProgress: Bool) {
        translationButton.isHidden = inProgress
        activityIndicator.isHidden = !inProgress
    }
// Removes the keyboard if displayed
    private func removeKeyboard() {
        textToTranslate.resignFirstResponder()
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
