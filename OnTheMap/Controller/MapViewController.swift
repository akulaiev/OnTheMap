//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Anna Kulaieva on 10/25/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout {
            self.performSegue(withIdentifier: "logOut", sender: self)
        }
    }
    
}
