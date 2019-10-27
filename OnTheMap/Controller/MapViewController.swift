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

class MyPointAnnotation: NSObject, MKAnnotation
{
    let identifier : String
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let color: UIColor
    
    init(identifier: String, title: String, subtitle: String, coordinate: CLLocationCoordinate2D, color: UIColor)
    {
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.color = color
        super.init()
    }
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var mapData = LocationModel.mapData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UdacityClient.getStudentsLocations { (response, error) in
            if let response = response {
                LocationModel.mapData = response.results
                self.mapData = response.results
                for pin in self.mapData {
                    let pinLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.latitude), longitude: CLLocationDegrees(pin.longitude))
                    let annotation = MyPointAnnotation(identifier: pin.objectId, title: pin.firstName + " " + pin.lastName, subtitle: pin.mediaURL, coordinate: pinLocation, color: .red)
                    self.placePin(annotation: annotation)
                }
            }
            else {
                print(error!.localizedDescription)
            }
        }
        mapView.delegate = self
        mapView.mapType = .standard
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {  
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    func placePin(annotation: MyPointAnnotation) {
        let annotation = annotation
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let newRegion = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.region = newRegion
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MyPointAnnotation
        {
            let identifier = annotation.identifier
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.animatesDrop = true
            view.pinTintColor = annotation.color
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: -3)
            return view
        }
        return nil
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout {
            self.performSegue(withIdentifier: "logOut", sender: self)
        }
    }
    
}
