//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Anna Kulaieva on 10/25/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}

class MapViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var mapData = LocationModel.mapData
    
    //Sets Mapview delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAndPlacePins()
        mapView.delegate = self
        mapView.mapType = .standard
    }

    //Performs request to load students location data, handles errors and places pins accordingly
    func getAndPlacePins() {
        UdacityClient.getStudentsLocations { (response, error) in
            if let response = response {
                LocationModel.mapData = response.results
                self.mapData = response.results
                for pin in self.mapData {
                    let pinLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.latitude), longitude: CLLocationDegrees(pin.longitude))
                    let annotation = MyPointAnnotation(identifier: pin.uniqueKey, title: pin.firstName + " " + pin.lastName, subtitle: pin.mediaURL, coordinate: pinLocation, color: .random)
                    annotation.placePin(mapView: self.mapView)
                }
            }
            else {
                SharedHelperMethods.showFailureAlert(title: "Problem with student locations download", message: error!.localizedDescription, controller: self)
            }
        }
    }
    
    //When user taps a pin, function checks if it's Url is valid and handles error or opens it in Safari
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            SharedHelperMethods.checkValidUrl(urlString: view.annotation!.subtitle!, controller: self)
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
            let button = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = button
            return view
        }
        return nil
    }
    
    //Performs logout request and dismisses the view controller
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //Deletes old annotations and calls the function to get the new ones and place them on map
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        let annotations = self.mapView.annotations
        for _annotation in annotations {
            if let annotation = _annotation as? MyPointAnnotation
            {
                self.mapView.removeAnnotation(annotation)
            }
        }
        getAndPlacePins()
    }
}
