//
//  PlacesAPIManager.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 18/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//
import Foundation

struct Constants {
    static let basePlacesURL : String = "maps.googleapis.com"
    static let APIKey : String =  "AIzaSyDHLS0waF5Kf4_XARDBvLrOmhXLdnSspRA"
}



class PlacesAPIManager : NSObject {
    
    static let instance = PlacesAPIManager()
    var session = URLSession.shared
    
    /**
     Used to trigger the Google Places API Request
     - parameters:
     - completion : Array of ATM objects
     */
    func determineAtmsNearby(completion : @escaping ([ATM]) -> Void){
        
        let placesSearchComponent = NSURLComponents()
        placesSearchComponent.scheme = "https"
        placesSearchComponent.host = Constants.basePlacesURL
        placesSearchComponent.path = "/maps/api/place/nearbysearch/json"
        
        // Build the query items for the api request
        let radiusQueryItem = URLQueryItem(name: "radius", value: "20000")
        let typeQueryItem = URLQueryItem(name: "type", value: "atm")
        let apiQueryItem = URLQueryItem(name: "key", value: Constants.APIKey)
        let location = URLQueryItem(name: "location", value: LocationManager.instance.getCoordinateString())
        
        
        placesSearchComponent.queryItems = [radiusQueryItem, typeQueryItem, apiQueryItem, location]
        
        let request = NSMutableURLRequest(url: placesSearchComponent.url!,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            var places : [ATM] = []
            
            if let data = data,
                
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                
                let results = json?.object(forKey: "results") as? NSArray
                
                for place in results! {
                    
                    do {
                        let place = try ATM(atmDictionary: place as! NSDictionary)
                        places.append(place)
                    } catch {
                        completion([])
                    }
                }
                completion(places)
            }
            
        }).resume()
        
    }
    
}

