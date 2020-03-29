//
//  PoiDetailViewController.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 17/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps



class PoiDetailViewController: UIViewController {
    
    
    @IBOutlet var imgPoi: UIImageView!
    @IBOutlet var imgSection: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var txtDesc: UITextView!
    @IBOutlet var btnDirections: UIButton!
    @IBOutlet var heightMap: NSLayoutConstraint!
    @IBOutlet var heightPic: NSLayoutConstraint!
    @IBOutlet var heightTxt: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var dirW: NSLayoutConstraint!
    @IBOutlet var dirH: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
