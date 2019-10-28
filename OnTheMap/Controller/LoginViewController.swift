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

    //Sets textfields delegates and button corner radius
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    //Clears textfields
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    //When user tapps the "login" button, function performs login request, handles errors and updates UI accordingly
    @IBAction func loginTapped(_ sender: UIButton) {
        SharedHelperMethods.updateUIState(isLoading: true, activityIndicator: activityIndicator, textfieldOne: emailTextField, textfieldTwo: passwordTextField, button: loginButton, buttonOptional: signUpButton)
        UdacityClient.getSessionID(username: emailTextField.text!, password: passwordTextField.text!) { (success, error) in
            SharedHelperMethods.updateUIState(isLoading: false, activityIndicator: self.activityIndicator, textfieldOne: self.emailTextField, textfieldTwo: self.passwordTextField, button: self.loginButton, buttonOptional: self.signUpButton)
            if !success {
                print(error!.localizedDescription)
                if error!.localizedDescription == "The Internet connection appears to be offline." {
                    SharedHelperMethods.showFailureAlert(title: "Login Failed!", message: error!.localizedDescription, controller: self)
                }
                else {
                    SharedHelperMethods.showFailureAlert(title: "Login Failed!", message: "Wrong login credentials.", controller: self)
                }
                return
            }
            else {
                self.performSegue(withIdentifier: "toMap", sender: self)
            }
        }
    }
    
    //When user tapps the "sign In" button, function opens Udacity's sign in page in Safari
    @IBAction func signUpTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }
}
