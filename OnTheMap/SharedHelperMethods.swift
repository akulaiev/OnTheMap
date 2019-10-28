//
//  SharedHelperMethods.swift
//  OnTheMap
//
//  Created by Anna Koulaeva on 28.10.2019.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation
import UIKit

class SharedHelperMethods {
    
    //Shows error alerts
    static func showFailureAlert(title: String, message: String, controller: UIViewController) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller.present(alertVC, animated: true)
    }
    
    //Updates controllers' UI while requests are performed
    static func updateUIState(isLoading: Bool, activityIndicator: UIActivityIndicatorView, textfieldOne: UITextField, textfieldTwo: UITextField, button: UIButton, buttonOptional: UIButton?) {
        if isLoading {
            activityIndicator.startAnimating()
        }
        else {
            activityIndicator.stopAnimating()
        }
        textfieldOne.isEnabled = !isLoading
        textfieldTwo.isEnabled = !isLoading
        button.isEnabled = !isLoading
        if let buttonOptional = buttonOptional {
            buttonOptional.isEnabled = !isLoading
        }
    }
    
    //Checks if the URL is valid abd opens it in Safari
    static func checkValidUrl(urlString: String?, controller: UIViewController) {
        let title = "Invalid URL"
        let message = "Browser cannot open the URL because it is broken or somehow invalid! Try another URL."
        guard var urlString = urlString else {
            showFailureAlert(title: title, message: message, controller: controller)
            return
        }
        if (urlString.hasPrefix("http") == false && urlString.hasPrefix("https") == false) {
            urlString = "http://" + urlString
        }
        guard let url = URL(string: urlString) else {
            showFailureAlert(title: title, message: message, controller: controller)
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            showFailureAlert(title: title, message: message, controller: controller)
            return
        }
    }
}
