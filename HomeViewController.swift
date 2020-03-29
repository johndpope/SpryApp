
//  by Spry Enterprise:
//
//  ------------------------------------------------------
//  Copyright (c) 2017-2018 Okorie Chinaza. All rights reserved.
//  ------------------------------------------------------

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var logo: SpringImageView!
    
    @IBOutlet var viewTop: UIView!
    @IBOutlet var heightTop: NSLayoutConstraint!
    @IBOutlet var widthPic: NSLayoutConstraint!
    @IBOutlet var heightPic: NSLayoutConstraint!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var widthView1: NSLayoutConstraint!
    @IBOutlet var heightView3: NSLayoutConstraint!
    @IBOutlet var widthView3: NSLayoutConstraint!
    @IBOutlet var heightView4: NSLayoutConstraint!
    
    @IBOutlet var main1: SpringImageView!
    @IBOutlet var main2: SpringImageView!
    @IBOutlet var main3: SpringImageView!
    @IBOutlet var main4: SpringImageView!
    @IBOutlet var wPic1: NSLayoutConstraint!
    @IBOutlet var wPic2: NSLayoutConstraint!
    @IBOutlet var wPic3: NSLayoutConstraint!
    @IBOutlet var wPic4: NSLayoutConstraint!
    
    @IBOutlet var icon1h: NSLayoutConstraint!
    @IBOutlet var icon1w: NSLayoutConstraint!
    @IBOutlet var icon2h: NSLayoutConstraint!
    @IBOutlet var icon2w: NSLayoutConstraint!
    @IBOutlet var icon3w: NSLayoutConstraint!
    @IBOutlet var icon3h: NSLayoutConstraint!
    @IBOutlet var icon4w: NSLayoutConstraint!
    @IBOutlet var icon4h: NSLayoutConstraint!
    
    
    @IBOutlet var lead1: NSLayoutConstraint!
    @IBOutlet var lead2: NSLayoutConstraint!
    @IBOutlet var lead3: NSLayoutConstraint!
    @IBOutlet var lead4: NSLayoutConstraint!
    
    @IBOutlet var lbl1: SpringLabel!
    @IBOutlet var lbl2: SpringLabel!
    @IBOutlet var lbl3: SpringLabel!
    @IBOutlet var lbl4: SpringLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.animation = "zoomIn"
        logo.duration = 1
        logo.delay = 0.5
        logo.animate()
        
        
        
        func btn1(_ sender: AnyObject) {
            main1.animation = "flipX"
            main1.duration = 0.5
            main1.animate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.performSegue(withIdentifier: "segueMapPoi", sender: nil )
            }
        }
        
        func btn2(_ sender: AnyObject) {
            main2.animation = "flipX"
            main2.duration = 0.5
            main2.animate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.performSegue(withIdentifier: "segueMapPoi", sender: nil )
            }
        }
        
        func btn3(_ sender: AnyObject) {
            main3.animation = "flipX"
            main3.duration = 0.5
            main3.animate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.performSegue(withIdentifier: "segueMapPoi", sender: nil )
            }
        }
        
        func btn4(_ sender: AnyObject) {
            main4.animation = "flipX"
            main4.duration = 0.5
            main4.animate()
            /* DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
             self.performSegue(withIdentifier: "segueMapPoi", sender: PLIST_MAIN_4)
             }*/
        }
        
        
        
        func formatView(){
            
            let cRadius = 6 as CGFloat
            
            viewTop.clipsToBounds = true
            viewTop.layer.cornerRadius = cRadius
            view1.clipsToBounds = true
            view1.layer.cornerRadius = cRadius
            view2.clipsToBounds = true
            view2.layer.cornerRadius = cRadius
            view3.clipsToBounds = true
            view3.layer.cornerRadius = cRadius
            view4.clipsToBounds = true
            view4.layer.cornerRadius = cRadius
            
            var viewWidth = 0 as CGFloat
            var viewHeight = 0 as CGFloat
            
            switch UIScreen.main.bounds.height {
                
            case 480: // iPhone 4
                viewWidth = 152
                viewHeight = 144
                
            case 568: // iPhone 5
                viewWidth = 152
                viewHeight = 193
                
            case 667: // iPhone 6/7/8
                
                viewWidth = 175
                viewHeight = 240
                
            case 736: // iPhone 6+/7+/8+
                
                viewWidth = 194
                viewHeight = 270
                
            case 812: // iPhone X
                
                viewWidth = 175
                viewHeight = 270
                
            case 1024, 1112, 1366: // iPad
                
                let wPic = 120 as CGFloat
                
                wPic1.constant = wPic
                wPic2.constant = wPic
                wPic3.constant = wPic
                wPic4.constant = wPic
                
                let iconSize = 80 as CGFloat
                
                icon1h.constant = iconSize
                icon1w.constant = iconSize
                icon2h.constant = iconSize
                icon2w.constant = iconSize
                icon3h.constant = iconSize
                icon3w.constant = iconSize
                icon4w.constant = iconSize
                icon4h.constant = iconSize
                
                let iconSpace = 30 as CGFloat
                
                lead1.constant = iconSpace
                lead2.constant = iconSpace
                lead3.constant = iconSpace
                lead4.constant = iconSpace
                
                let fontSize = 32 as CGFloat
                
                lbl1.font = UIFont(name: lbl1.font.fontName, size: fontSize)
                lbl2.font = UIFont(name: lbl2.font.fontName, size: fontSize)
                lbl3.font = UIFont(name: lbl3.font.fontName, size: fontSize)
                lbl4.font = UIFont(name: lbl4.font.fontName, size: fontSize)
                
                heightTop.constant = 150
                widthPic.constant = 415
                heightPic.constant = 130
                
                
                let wDevice = UIScreen.main.bounds.width
                let w = wDevice / 2 - 10
                viewWidth = w
                
                let hDevice = UIScreen.main.bounds.height
                let h = hDevice / 2 - 120
                viewHeight = h
                
            default: break
                
            }
            
            widthView1.constant = viewWidth
            widthView3.constant = viewWidth
            heightView3.constant = viewHeight
            heightView4.constant = viewHeight
            
        }
        
        func showLocationServicesDeniedAlert() {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default,handler: nil)
            present(alert, animated: true, completion: nil)
            alert.addAction(okAction)
        }
        
        
}
}
