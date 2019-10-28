//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by Anna Koulaeva on 26.10.2019.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    
    var location: CLLocationCoordinate2D?
    var placemark: String = ""
    var url: String = ""
    var userData: StudentInformation?
    
    //Sets map view delegate and places location pin on map
    override func viewDidLoad() {
        super.viewDidLoad()
        finishButton.layer.cornerRadius = 5
        mapView.delegate = self
        if let location = location {
            let pinLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude))
            let annotation = MyPointAnnotation(identifier: UdacityClient.AuthenticationInfo.apiKey, title: placemark, subtitle: "", coordinate: pinLocation, color: .red)
            annotation.placePin(mapView: self.mapView)
        }
    }
    
    //Sets properties of custom annotation view and returns the view for pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MyPointAnnotation
        {
            let identifier = annotation.identifier
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.animatesDrop = true
            view.pinTintColor = annotation.color
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -7, y: -3)
            return view
        }
        return nil
    }
    
    //Performs request to get user's first and last name, handles errors. Then populates student info struct with other data and performs post request
    func getAndPostUserData() {
        UdacityClient.getUserData { (response, error) in
            guard let response = response else {
                print(error!.localizedDescription)
                return
            }
            self.userData = StudentInformation(uniqueKey: UdacityClient.AuthenticationInfo.apiKey, firstName: response.firstName, lastName: response.lastName, mapString: self.placemark, mediaURL: self.url, latitude: Float(self.location!.latitude), longitude: Float(self.location!.longitude))
            UdacityClient.postStudentLocation(userData: self.userData!) { (success, error) in
                if !success {
                    print(error!.localizedDescription)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //Calls getAndPostUserData() function when "Finish" button is tapped
    @IBAction func finishTapped(_ sender: UIButton) {
        getAndPostUserData()
    }
}
