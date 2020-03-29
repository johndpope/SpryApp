//
//  ATM.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 18/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

enum SerializationError : Error {
    case missing(String)
    case invalid(String, Any)
}

class ATM : NSObject, MKAnnotation {
    
    let title : String?
    let latitude : Double
    let longitude : Double
    var subtitle : String?
     let status : String?
    var coordinate: CLLocationCoordinate2D
    
    init(atmDictionary : NSDictionary)throws{
        
        // Error handling
        guard let name = atmDictionary["name"] as? String else {
            throw SerializationError.missing("name")
        }
        guard let geometry = atmDictionary["geometry"] as? NSDictionary else {
            throw SerializationError.missing("gemoetry")
        }
        guard let location = geometry["location"] as? NSDictionary else {
            throw SerializationError.missing("location")
        }
        guard let latitude = location["lat"] as? Double else {
            throw SerializationError.missing("latitude")
        }
        guard let longitude = location["lng"] as? Double else {
            throw SerializationError.missing("longitude")
        }
        
        // Initialise Properties
        self.title = name
        self.longitude = longitude
        self.latitude = latitude
        self.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        
        // Initially this is not calculated
        self.subtitle = "N/L"
        self.status = " "
    }
    
    /**
     Used to update the Atm object with the distance from the user as the value for 'subtitle' property
     - parameters:
     - coordinate : Coordinate
     */
    func updateAtmLocation(coordinate : CLLocationCoordinate2D){
        self.subtitle = LocationManager.instance.calculateDistance(location: coordinate)
    }
    
}
