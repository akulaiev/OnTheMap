//
//  MyPointAnnotation.swift
//  OnTheMap
//
//  Created by Anna Koulaeva on 28.10.2019.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation
import MapKit

//Custom annotation class
class MyPointAnnotation: NSObject, MKAnnotation
{
    let identifier : String
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let color: UIColor
    let button: UIButton
    
    init(identifier: String, title: String, subtitle: String, coordinate: CLLocationCoordinate2D, color: UIColor)
    {
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.color = color
        self.button = UIButton(type: .infoLight)
        super.init()
    }
    
    func placePin(mapView: MKMapView) {
        mapView.addAnnotation(self)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let newRegion = MKCoordinateRegion(center: self.coordinate, span: span)
        mapView.region = newRegion
    }
}
