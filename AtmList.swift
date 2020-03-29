//
//  AtmList.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 18/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//


import Foundation
import CoreLocation

class AtmList: NSObject {
    
    static let instance = AtmList()
    
    var atms : [ATM] = []
    
    func addAtm(atm : ATM){
        atms.append(atm)
    }
    
    func resetBarList(){
        atms = []
    }
    
  
    func getAtmsCount() -> Int{
        return atms.count
    }
    
    func udpateAtms(index : Int, coordinate : CLLocationCoordinate2D){
        atms[index].updateAtmLocation(coordinate: coordinate)
    }
    
}
