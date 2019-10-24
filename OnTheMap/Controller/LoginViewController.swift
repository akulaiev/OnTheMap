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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        UdacityClient.getSessionID(username: emailTextField.text!, password: passwordTextField.text!) { (success, error) in
            if !success {
                self.showLoginFailure(message: "Wrong login credentials!")
                return
            }
            else {
                print(UdacityClient.AuthenticationInfo.apiKey)
                print(UdacityClient.AuthenticationInfo.sessionId)
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
}
