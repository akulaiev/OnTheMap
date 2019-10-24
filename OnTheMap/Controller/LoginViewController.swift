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
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
    }
}
