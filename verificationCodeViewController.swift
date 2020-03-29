//
//  verificationCodeViewController.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 21/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import UIKit
import FirebaseAuth

class verificationCodeViewController: UIViewController {


    @IBOutlet weak var phoneNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNum.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendCode(_ sender: Any) {
        let alert = UIAlertController(title: "Phone number", message: "Is this your phone Number? \n \( "+234" + self.phoneNum.text!)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default){ (UIAlertAction) in
            PhoneAuthProvider.provider().verifyPhoneNumber("+234" + self.phoneNum.text!) { (verificationID, error) in
                if error != nil{
                    print("error:\(String(describing: error?.localizedDescription))")
                } else {
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVID")
                    self.performSegue(withIdentifier: "code", sender: Any?.self)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneNum.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange(textField:UITextField){
        
        let text = textField.text
        
        if text?.utf16.count == 14 {
            
            switch textField{
                
            case phoneNum:
                phoneNum.resignFirstResponder()
            default:
                break
            }
            
        }
        else {
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   


    
    
}

