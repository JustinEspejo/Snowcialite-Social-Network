//
//  MapViewController.swift
//  Snowcialite iOS App
//
//  Created by Justin Espejo on 10/28/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
    }

    // Location Delegate methods  
    
}