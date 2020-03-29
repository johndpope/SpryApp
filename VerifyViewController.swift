//
//  SignUpViewController.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 19/01/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VerifyViewController: UIViewController , UITextFieldDelegate  {

    @IBOutlet weak var tf1: UITextField!
  

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        

        // Do any additional setup after loading the view.
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tf1.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange(textField:UITextField){
        
        let text = textField.text
        
        if text?.utf16.count == 6 {
            
            switch textField{
                
            case tf1:
                tf1.resignFirstResponder()
            default:
                break
            }
            
        }
        else {
            
        }
        
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
  
    
    
    @IBAction func loggedIn(_ sender: Any) {
        let defaults = UserDefaults.standard
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID:defaults.string(forKey:"authVID")!, verificationCode: tf1.text!)
        Auth.auth().signIn(with: credential) { (user,error)  in
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
            } else {
                print("Phone number: \(String(describing: user?.phoneNumber))")
                let userInfo = user?.providerData[0]
                print("Provider ID: \(String(describing: userInfo?.providerID))")
                self.performSegue(withIdentifier: "logged", sender: Any?.self)
                
    
                }
                
            }
            
        }
    }
    


