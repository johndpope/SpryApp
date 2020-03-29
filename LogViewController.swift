//
//  LogViewController.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 17/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LogViewCell : UITableViewCell {

    @IBOutlet weak var imgPlace: UIImageView!
    
    @IBOutlet weak var denomLabel: UILabel!
    
    @IBOutlet weak var securityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}


class LogViewController: UITableViewController {
    
    
    var atms : [ATM] = []
    var errorAlert : UIAlertController!
    var timer : Timer!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initialiseErrorAlert()
        
        self.title = "ATMs"
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(waitTimer), userInfo: nil, repeats: true)
        
    }
    
    /**
     Noticed the Location Manager has a minor delay before the current location of the user is determined hence the waitTimer function
     */
    @objc func waitTimer(){
        
        if LocationManager.instance.lastLocation != nil {
            
            timer.invalidate()
            
            triggerAPIRequest()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if LocationManager.instance.checkAuthourization() != true {
            
            self.displayAlert(errorAlert: self.errorAlert!, message: "Please ensure location services have been enabled and retry")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return AtmList.instance.getAtmsCount()
   }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 // Assign the height as per your view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "atmCell", for: indexPath) as! LogViewCell
        
        cell.titleLabel?.text = AtmList.instance.atms[indexPath.row].title
        cell.titleLabel?.textColor=UIColor.black
        cell.titleLabel?.font=UIFont.systemFont(ofSize: 14)
        cell.subtitleLabel?.text = AtmList.instance.atms[indexPath.row].subtitle
         cell.subtitleLabel?.font=UIFont.systemFont(ofSize: 11)
        //let atmName = AtmList.instance.atms[indexPath.row].title
       // cell.label?.text = atmName
       // cell.fruitImageView?.image = UIImage(named: fruitName)
        
       // cell.imgPlace?.image
        
      //  cellImage.image
       //let imgName = "Icon\((atms[indexPath.row] as AnyObject).object(forKey: "title") as! String)"
        
        if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "W" {
             cell.imgPlace?.image = UIImage(named: "wemaBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "A"  {
            cell.imgPlace?.image = UIImage(named: "AccessBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "C"  {
            cell.imgPlace?.image = UIImage(named: "CitiBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "D"  {
            cell.imgPlace?.image = UIImage(named: "DiamondBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "H"  {
            cell.imgPlace?.image = UIImage(named: "HeritageBank_Pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "P"  {
            cell.imgPlace?.image = UIImage(named: "ProvidusBank_pin")
        } else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 2))!])! == "D" {
           cell.imgPlace?.image = UIImage(named: "FidelityBank_pin")
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "C" {
            cell.imgPlace?.image = UIImage(named: "FCMB_pin")
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 5))!])! == "C" {
            cell.imgPlace?.image = UIImage(named: "FCMB_pin")
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text!.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "o" {
            cell.imgPlace?.image = UIImage(named: "UnionBank_pin")
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G"  {
            cell.imgPlace?.image = UIImage(named: "GTBank_pin")
        }else if   cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 1))!])! == "U" {
            cell.imgPlace?.image = UIImage(named: "GTBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "F"  {
            cell.imgPlace?.image = UIImage(named: "FirstBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "K"  {
            cell.imgPlace?.image = UIImage(named: "KeystoneBank_pin")
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" && (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 2))!])! == "y" {
            cell.imgPlace?.image = UIImage(named: "skyeBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "Z"  {
            cell.imgPlace?.image = UIImage(named: "ZenithBank_pin")
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "b" {
            cell.imgPlace?.image = UIImage(named: "UBA_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "y" {
            cell.imgPlace?.image = UIImage(named: "UnityBank_pin")
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "B" {
            cell.imgPlace?.image = UIImage(named: "StanbicIBTC_pin")
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "D" {
            cell.imgPlace?.image = UIImage(named: "StandardCharteredBank_pin")
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "R" {
            cell.imgPlace?.image = UIImage(named: "SterlingBank")
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "U" {
            cell.imgPlace?.image = UIImage(named: "SuntrustBank_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "e" {
           cell.imgPlace?.image = UIImage(named: "UBA_pin")
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "c"  {
            cell.imgPlace?.image = UIImage(named: "ecoBank_pin")
         }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "n"  {
            cell.imgPlace?.image = UIImage(named: "EnterpriseBank_pin")
        }
        
        //STATUS OF ATM
        cell.statusLabel.textColor=UIColor.orange
        cell.statusLabel.font=UIFont.systemFont(ofSize: 10)
        
        if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "W" {
           cell.statusLabel.text = "Status: Temporarily unable to dispense cash"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "A"  {
           cell.statusLabel.text = "Status: Service UnAvailable"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "C"  {
            cell.statusLabel.text = "Status: Available"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "D"  {
             cell.statusLabel.text = "Status: Available"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "H"  {
            cell.statusLabel.text = "Status: Temporarily unable to dispense cash"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "P"  {
             cell.statusLabel.text = "Status: Available"
        } else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 2))!])! == "D" {
             cell.statusLabel.text = "Status: Temporarily unable to dispense cash"
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "C" {
            cell.statusLabel.text = "Status: Service UnAvailable"
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 5))!])! == "C" {
           cell.statusLabel.text = "Status: Temporarily unable to dispense cash"
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text!.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "o" {
            cell.statusLabel.text = "Status: Temporarily unable to dispense cash"
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G"  {
           cell.statusLabel.text = "Status: Available"
        }else if   cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 1))!])! == "U" {
            cell.statusLabel.text = "Status: Service UnAvailable"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "F"  {
            cell.statusLabel.text = "Status: Available"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "K"  {
            cell.statusLabel.text = "Status: Available"
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" && (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 2))!])! == "y" {
           cell.statusLabel.text = "Status: Service UnAvailable"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "Z"  {
            cell.statusLabel.text = "Status: Available"
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "b" {
           cell.statusLabel.text = "Status: Service UnAvailable"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "y" {
           cell.statusLabel.text = "Status: Available"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "B" {
            cell.statusLabel.text = "Status: Available"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "D" {
            cell.statusLabel.text = "Status: Available"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "R" {
            cell.statusLabel.text = "Status: Available"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "U" {
            cell.statusLabel.text = "Status: Available"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "e" {
            cell.statusLabel.text = "Status: Available"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "c"  {
           cell.statusLabel.text = "Status: Available"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "n"  {
           cell.statusLabel.text = "Status: Available"
            }
 
        // CURRENCY DENOMINATION ATM IS PAYING
        
        cell.denomLabel.textColor=UIColor.blue
        cell.denomLabel.font=UIFont.systemFont(ofSize: 10)
        
        if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "W" {
           cell.denomLabel.text = "Currency Denomination: N500"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "A"  {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "C"  {
            cell.denomLabel.text = "Currency Denomination: N500"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "D"  {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "H"  {
            cell.denomLabel.text = "Currency Denomination: N500"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "P"  {
             cell.denomLabel.text = "Currency Denomination: N500"
        } else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 2))!])! == "D" {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "C" {
             cell.denomLabel.text = "Currency Denomination: N500"
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 5))!])! == "C" {
            cell.denomLabel.text = "Currency Denomination: N500"
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text!.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "o" {
           cell.denomLabel.text = "Currency Denomination: N1000"
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G"  {
            cell.denomLabel.text = "Currency Denomination: N500"
        }else if   cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 1))!])! == "U" {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "F"  {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "K"  {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" && (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 2))!])! == "y" {
           cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "Z"  {
           cell.denomLabel.text = "Currency Denomination: N1000"
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "b" {
           cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "y" {
            cell.denomLabel.text = "Currency Denomination: N1000"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "B" {
             cell.denomLabel.text = "Currency Denomination: N500"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "D" {
            cell.denomLabel.text = "Currency Denomination: N1000"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "R" {
            cell.denomLabel.text = "Currency Denomination: N1000"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "U" {
           cell.denomLabel.text = "Currency Denomination: N500"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "e" {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "c"  {
            cell.denomLabel.text = "Currency Denomination: N1000"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "n"  {
           cell.denomLabel.text = "Currency Denomination: N1000"
        }
        
        
        
      
        // HOW SAFE THE AREA ODF ATM LOCATION IS
        
        cell.securityLabel.textColor=UIColor.red
        cell.securityLabel.font=UIFont.systemFont(ofSize: 10)
        
        if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "W" {
           cell.securityLabel.text = "Security: UnSafe, advised not to withdraw at night"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "A"  {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "C"  {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "D"  {
          cell.securityLabel.text = "Security: UnSafe, advised not to withdraw at night "
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "H"  {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "P"  {
            cell.securityLabel.text = "Security: Safe"
        } else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 2))!])! == "D" {
            cell.securityLabel.text = "Security: UnSafe, advised not to withdraw at night "
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "C" {
            cell.securityLabel.text = "Security: Safe"
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "F" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text?.startIndex)!, offsetBy: 5))!])! == "C" {
            cell.securityLabel.text = "Security: Safe"
        } else if  (cell.titleLabel?.text![(cell.titleLabel?.text!.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "o" {
            cell.securityLabel.text = "Security: Safe"
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G"  {
           cell.securityLabel.text = "Security: UnSafe, advised not to withdraw at night "
        }else if   cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "G" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 1))!])! == "U" {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "F"  {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "K"  {
            cell.securityLabel.text = "Security: Safe"
        }else if cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" && (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 2))!])! == "y" {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "Z"  {
            cell.securityLabel.text = "Security: Safe"
        }else if (cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!])! == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "b" {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "y" {
            cell.securityLabel.text = "Security: Safe"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "B" {
            cell.securityLabel.text = "Security: UnSafe, advised not to withdraw at night"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "D" {
            cell.securityLabel.text = "Security: Safe"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 3))!])! == "R" {
            cell.securityLabel.text = "Security: UnSafe, advised not to withdraw at night"
        } else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "S" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "U" {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "U" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index((cell.titleLabel?.text!.startIndex)!, offsetBy: 4))!])! == "e" {
            cell.securityLabel.text = "Security: UnSafe, advised not to withdraw at night"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "C"  {
            cell.securityLabel.text = "Security: Safe"
        }else if  cell.titleLabel?.text![(cell.titleLabel?.text?.startIndex)!] == "E" &&  (cell.titleLabel?.text![(cell.titleLabel?.text!.index(after: (cell.titleLabel?.text!.startIndex)!))!])! == "n"  {
            cell.securityLabel.text = "Security: Safe"
        }

        
        return cell
        
    }
   

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let atmLocation = AtmList.instance.atms[indexPath.row]
        openGoogleMaps(location: atmLocation)
       
        
    }
    
    func openGoogleMaps(location : ATM){
        
        let startPlacemark : MKPlacemark = MKPlacemark(coordinate: LocationManager.instance.lastLocation!.coordinate, addressDictionary: nil)
        let startMapItem : MKMapItem = MKMapItem(placemark: startPlacemark)
        startMapItem.name = "User location"
        
        let destinationPlacemark : MKPlacemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        destinationMapItem.name = location.title!
        
        
        let mapItems = [startMapItem,destinationMapItem]
        
        let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        
        MKMapItem.openMaps(with: mapItems, launchOptions: options)
    }
    
    
    // MARK: API Methods
    
    /**
     Triggers the API method but first ensures the user's current location has been determined.
     */
    func triggerAPIRequest(){
        
        guard (LocationManager.instance.lastLocation != nil) else {
            return
        }
        
        // First we get all the nearby ATMs, then reload the table view in the main thread.
        PlacesAPIManager.instance.determineAtmsNearby() { (atmsNearBy) in
            
            AtmList.instance.atms = atmsNearBy
            
            
            DispatchQueue.main.async {
                
                if AtmList.instance.getAtmsCount() == 0 {
                    self.displayAlert(errorAlert: self.errorAlert!, message: "No ATMs were found at this time. \nPlesea try again later.")
                }
                
                self.triggerUpdateOfLocationLabels(atmsNearBy: atmsNearBy)
            }
            
        }
        
    }
    
    /**
     This triggers the updates of all the atms stored in the ATMlist with a distance value as the subtitle
     */
    func triggerUpdateOfLocationLabels(atmsNearBy : [ATM]){
        
        if LocationManager.instance.checkAuthourization() == true {
            
            for i in 0 ..< atmsNearBy.count {
                AtmList.instance.udpateAtms(index: i, coordinate: atmsNearBy[i].coordinate)
            }
            
            self.tableView.reloadData()
         
            
        } else {
            self.displayAlert(errorAlert: self.errorAlert!, message: "Please ensure location services have been enabled and retry")
        }
        
    }
    
    // As the methods exist both in the maps and list controllers, a better approach would;ve been to implement a base uiviewcontroller and subclass both.
    
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
