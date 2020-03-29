//
//  LocationManager.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 18/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let instance: LocationManager = LocationManager()
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    
    var locationCounter : Int = 0
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .denied {
            // Push notification to show alert
        }
        
        locationManager.distanceFilter = kCLLocationAccuracyBest;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    /**
     Calculates the distance between the user and a given location
     - Parameters:
     - location: ATM location coordinate
     */
    func calculateDistance(location: CLLocationCoordinate2D) -> String {
        
        let distanceLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        var distance = self.lastLocation!.distance(from: distanceLocation)
        
        let locationInFoot = distance * 3.28084
        
        var locationString = String(format: "%d ft", Int(locationInFoot))
        
        if locationInFoot > 656.168 {
            // Over 200ft
            distance = distance / 1609.34
            
            locationString =  String(format: "%.01f miles", distance)
        }
        
        return locationString
        
    }
    
    /**
     - returns : location coordinates of the user
     */
    func getCoordinateString() -> String {
        
        let coordinateString =  String(format: "%.4f,%.4f", self.lastLocation!.coordinate.latitude, self.lastLocation!.coordinate.longitude)
        
        return coordinateString
    }
    
    
    /**
     - returns : Boolean status based on location services access
     */
    func checkAuthourization() -> Bool{
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
                
            case .authorizedAlways,.authorizedWhenInUse:
                return true
            }
        }
        
        return false
        
    }
    
    // MARK:  CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastLocation = locations.last!
    }
    
}


