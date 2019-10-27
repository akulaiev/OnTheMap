//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Anna Kulaieva on 10/23/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
        emailTextField.text = "paprika1@ukr.net"
        passwordTextField.text = "natalia39"
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        updateUIState(isLoading: true)
        UdacityClient.getSessionID(username: emailTextField.text!, password: passwordTextField.text!) { (success, error) in
            self.updateUIState(isLoading: false)
            if !success {
                self.showLoginFailure(message: "Wrong login credentials!")
                return
            }
            else {
//                print(UdacityClient.AuthenticationInfo.apiKey)
//                print(UdacityClient.AuthenticationInfo.sessionId)
                self.performSegue(withIdentifier: "toMap", sender: self)
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }
    
    func updateUIState(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        }
        else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !isLoading
        passwordTextField.isEnabled = !isLoading
        loginButton.isEnabled = !isLoading
        signUpButton.isEnabled = !isLoading
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
}
