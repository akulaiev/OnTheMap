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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var location: CLLocationCoordinate2D?
    var placemark: String = ""
    
    //Sets the initial state of textfields and corner radius for the button
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.text = ""
        linkTextField.text = ""
        findLocationButton.layer.cornerRadius = 5
    }

    //Gets the proper location name for the request, handles errors and segues to show the location on map
    func getPlacemark() {
        if self.linkTextField.text?.isEmpty == false {
            if let location = self.location {
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude), completionHandler: { (placemarks, error) in
                    if error == nil {
                        var address = (placemarks?[0].locality)! + ", "
                        address += (placemarks?[0].name)!
                        self.placemark = address
                    }
                    else {
                        self.placemark = self.locationTextField.text!
                    }
                    self.performSegue(withIdentifier: "toMapView", sender: self)
                })
            }
        }
        else {
            SharedHelperMethods.showFailureAlert(title: "Empty link field", message: "Please, insert the valid URL.", controller: self)
        }
    }
    
    //Searches for the queried location
    func performLocationSearch(requestStr: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = requestStr
        SharedHelperMethods.updateUIState(isLoading: true, activityIndicator: activityIndicator, textfieldOne: locationTextField, textfieldTwo: linkTextField, button: findLocationButton, buttonOptional: nil)
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            SharedHelperMethods.updateUIState(isLoading: false, activityIndicator: self.activityIndicator, textfieldOne: self.locationTextField, textfieldTwo: self.linkTextField, button: self.findLocationButton, buttonOptional: nil)
            UIApplication.shared.endIgnoringInteractionEvents()
            guard let response = response else {
                SharedHelperMethods.showFailureAlert(title: "Couldn't find the location!", message: "Please, make sure your location input is valid.", controller: self)
                return
            }
            let latitude = response.boundingRegion.center.latitude
            let longitude = response.boundingRegion.center.longitude
            self.location = CLLocationCoordinate2DMake(latitude, longitude)
            self.getPlacemark()
        }
    }
    
    //Sets the data to show it on the map
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "toMapView" {
            let VC = segue.destination as! AddLocationMapViewController
            VC.location = location
            VC.placemark = placemark
            VC.url = linkTextField.text!
        }
    }
    
    //Calls the function to search location whrn the user taps the "Find" button
    @IBAction func findLocationButtonTapped(_ sender: UIButton) {
        performLocationSearch(requestStr: locationTextField.text!)
    }
    
    //Dismisses VC when "Cancel" button is tapped
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
