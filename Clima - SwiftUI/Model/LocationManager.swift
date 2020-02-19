//
//  LocationManager.swift
//  Clima - SwiftUI
//
//  Created by Maya Fenelon on 12/10/19.
//  Copyright © 2019 Maya Fenelon. All rights reserved.
//
import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager() 
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        //makes the manager constant a delagate 
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // stops updating the user's location
    func finish() {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate 
        //stops updating the user's current Location
        manager.stopUpdatingLocation() 
    }
}
