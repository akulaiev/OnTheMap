//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Anna Koulaeva on 26.10.2019.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.text = ""
        linkTextField.text = ""
        // Do any additional setup after loading the view.
    }

    func performLocationSearch(requestStr: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = requestStr
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            UIApplication.shared.endIgnoringInteractionEvents()
            guard let response = response else {
                self.showAlert(message: error!.localizedDescription)
                return
            }
            let latitude = response.boundingRegion.center.latitude
            let longitude = response.boundingRegion.center.longitude
            let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            print(coordinate)
        }
    }
    
    @IBAction func findLocationButtonTapped(_ sender: UIButton) {
        performLocationSearch(requestStr: locationTextField.text!)
    }
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
}
