//
//  Users.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 05/05/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


struct Users {
    
    var username: String!
    var email: String?
    var state: String?
    var storedImage: String!
    var uid: String!
    var ref: DatabaseReference?
    var key: String?
    var firstName: String!
    var lastName: String!
    
    init(snapshot: DataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        username = (snapshot.value! as! NSDictionary)["username"] as! String
        email = (snapshot.value! as! NSDictionary)["email"] as? String
        state = (snapshot.value! as! NSDictionary)["state"] as? String
        uid = (snapshot.value! as! NSDictionary)["uid"] as! String
        storedImage = (snapshot.value! as! NSDictionary)["photoURL"] as! String
        firstName = (snapshot.value! as! NSDictionary)["firstName"] as! String
         lastName = (snapshot.value! as! NSDictionary)["lastName"] as! String
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return ["email"]
    //    }
    
}
