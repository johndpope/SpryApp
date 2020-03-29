//
//  PlaceMarker.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 09/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {
   
    let place: GooglePlace
    
    init(place: GooglePlace) {
        self.place = place
        super.init()
        
        position = place.coordinate
        
        //Adding icons to maps as atm pinpoints
        if place.name[place.name.startIndex] == "W" {
            icon = UIImage(named: "wemaBank_pin")// takes a Character or a literal
        }else if  place.name[place.name.startIndex] == "A"  {
            icon = UIImage(named: "AccessBank_pin")
        }else if  place.name[place.name.startIndex] == "C"  {
            icon = UIImage(named: "CitiBank_pin")
        }else if  place.name[place.name.startIndex] == "D"  {
            icon = UIImage(named: "DiamondBank_pin")
        }else if  place.name[place.name.startIndex] == "H"  {
            icon = UIImage(named: "HeritageBank_Pin")
        }else if  place.name[place.name.startIndex] == "P"  {
            icon = UIImage(named: "ProvidusBank_pin")
        } else if  place.name[place.name.startIndex] == "F" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 2)] == "D" {
            icon = UIImage(named: "FidelityBank_pin")
        }else if  place.name[place.name.startIndex] == "F" &&  place.name[place.name.index(after: place.name.startIndex)] == "C" {
                icon = UIImage(named: "FCMB_pin")
        } else if  place.name[place.name.startIndex] == "F" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 5)] == "C" {
            icon = UIImage(named: "FCMB_pin")
        } else if  place.name[place.name.startIndex] == "U" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 3)] == "o" {
            icon = UIImage(named: "UnionBank_pin")
        }else if  place.name[place.name.startIndex] == "G"  {
            icon = UIImage(named: "GTBank_pin")
        }else if  place.name[place.name.startIndex] == "G" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 1)] == "U" {
            icon = UIImage(named: "GTBank_pin")
        }else if  place.name[place.name.startIndex] == "F"  {
            icon = UIImage(named: "FirstBank_pin")
        }else if  place.name[place.name.startIndex] == "K"  {
            icon = UIImage(named: "KeystoneBank_pin")
        }else if  place.name[place.name.startIndex] == "S" && place.name[place.name.index(place.name.startIndex, offsetBy: 2)] == "y" {
            icon = UIImage(named: "skyeBank_pin")
        }else if  place.name[place.name.startIndex] == "E"  {
            icon = UIImage(named: "ecoBank_pin")
        }else if  place.name[place.name.startIndex] == "Z"  {
            icon = UIImage(named: "ZenithBank_pin")
        }else if  place.name[place.name.startIndex] == "U" &&  place.name[place.name.index(after: place.name.startIndex)] == "b" {
            icon = UIImage(named: "UBA_pin")
        }else if  place.name[place.name.startIndex] == "U" &&  place.name[place.name.index(place.name.startIndex, offsetBy:4)] == "y" {
            icon = UIImage(named: "UnityBank_pin")
        } else if  place.name[place.name.startIndex] == "S" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 4)] == "b" {
            icon = UIImage(named: "StanbicIBTC_pin")
        } else if  place.name[place.name.startIndex] == "S" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 4)] == "d" {
            icon = UIImage(named: "StandardCharteredBank_pin")
        } else if  place.name[place.name.startIndex] == "S" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 3)] == "r" {
            icon = UIImage(named: "SterlingBank")
        }else if  place.name[place.name.startIndex] == "S" &&  place.name[place.name.index(after: place.name.startIndex)] == "U" {
            icon = UIImage(named: "SuntrustBank_pin")
        }else if  place.name[place.name.startIndex] == "U" &&  place.name[place.name.index(place.name.startIndex, offsetBy: 4)] == "e" {
            icon = UIImage(named: "UBA_pin")
        }
        
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
}
