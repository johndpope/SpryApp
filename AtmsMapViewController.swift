//
//  AtmsMapViewController.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 18/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import UIKit
import MapKit

class  AtmsMapViewController: UIViewController {
    

    @IBOutlet weak var atmsMapView: MKMapView!
    
    var errorAlert : UIAlertController!
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseErrorAlert()
        
        self.title = "MAP"
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(waitTimer), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if LocationManager.instance.checkAuthourization() != true {
            
            self.displayAlert(errorAlert: self.errorAlert!, message: "Please ensure location services have been enabled and retry")
            
        } else {
            
            zoomToRegion()
            
            if atmsMapView.annotations.count == 0 {
                
                setupMapAnnotations()
            }
        }
    }
    
    
    func setupMapAnnotations(){
        
        guard AtmList.instance.getAtmsCount() > 0 else {
            return
        }
        
        let annotations = AtmList.instance.atms as [MKAnnotation]
        
        atmsMapView.addAnnotations(annotations)
        
        
    }
    @objc func waitTimer(){
        
        if LocationManager.instance.lastLocation != nil {
            
            timer.invalidate()
            
            setupMapAnnotations()
            
        }
    }
    
    func zoomToRegion() {
        
        guard LocationManager.instance.lastLocation != nil else {
            return
        }
        
        let location = CLLocationCoordinate2D(latitude: LocationManager.instance.lastLocation!.coordinate.latitude, longitude: LocationManager.instance.lastLocation!.coordinate.longitude)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        
        atmsMapView.setRegion(region, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Ensures the error alert is initialised
     */
    func initialiseErrorAlert(){
        
        errorAlert = UIAlertController(title: "", message: "", preferredStyle:.alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.default, handler: nil)
        errorAlert?.addAction(okButton)
    }
    
    /**
     Displays the error alert when triggered
     */
    func displayAlert(errorAlert : UIAlertController, message : String){
        errorAlert.message = NSLocalizedString(message, comment: "error message")
        present(errorAlert, animated: true, completion: nil)
    }
    
    
}

