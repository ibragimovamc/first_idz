//
//  ActivityViewViewController.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 22.01.2022.
//

import UIKit
import CoreLocation
import MapKit


class ActivityViewViewController: UIViewController {
    

    @IBOutlet weak var MapViewActivity: MKMapView!
    
    let locationManager: CLLocationManager = {
       let manager =  CLLocationManager()
      

        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        return manager
    }()
 
    override func viewDidLoad() {
            super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        MapViewActivity.showsUserLocation.self = true
        
    }
}

extension ActivityViewViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else{
            return
        }
        print("координаты устройства:", currentLocation.coordinate)
    }
    
    
}


