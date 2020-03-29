//
//  EditProfileViewController.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 23/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
//import SDWebImage


class EditProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    
    //variable
    let databaseRef = Database.database().reference(fromURL: "https://sprylocator.firebaseio.com/")
    let storageRef = Storage.storage().reference()
    
     var profileImageURL: String!
    
     //add your own outlets here and connect them to your storyboard!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var surnameEdit: UITextField!
    @IBOutlet weak var firstnameEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var stateOfResidenceEdit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setUpProfile()
      
        
        //Load user details
       // let userFirstName = PFUser.currentUser()?.objectForKey("first_name") as! String
       // let userLastName = PFUser.currentUser()?.objectForKey("last_name") as! String
        
       // firstnameEdit.text = userFirstName
      //  surnameEdit.text = userLastName

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func uploadImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let firstname = firstnameEdit.text else{
            print("firstname issue")
            return
        }
        guard let email = emailEdit.text else{
            print("email issue")
            return
        }
        guard let lastName = surnameEdit.text else{
            print("surname issue")
            return
        }
        guard let state = stateOfResidenceEdit.text else{
            print("state issue")
            return
        }
        
        let user = Auth.auth().currentUser
        guard let uid = user?.uid else{
            return
        }
        
        let userReference = self.databaseRef.child("users").child(uid)
        let values = ["firstname": firstname, "lastName": lastName, "email": email, "state": state, "profileImageURL" : ""]
        
        userReference.updateChildValues(values
            , withCompletionBlock: { (error, ref) in
                if error != nil{
                    print(error!)
                    return
                }
                self.dismiss(animated: true, completion: nil)
                let imageName = NSUUID().uuidString
                
                let storedImage = self.storageRef.child("profilePictures/").child(imageName)
                
                if let uploadData = UIImagePNGRepresentation(self.profilePicture.image!)
                {
                    storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil{
                            print(error!)
                            return
                        }
                        storedImage.downloadURL(completion: { (url, error) in
                            if error != nil{
                                print(error!)
                                return
                            }
                            if let urlText = url?.absoluteString{
                                self.databaseRef.child("users").child((Auth.auth().currentUser!.uid)).updateChildValues(["pic" : urlText], withCompletionBlock: { (error, ref) in
                                    if error != nil{
                                        print(error!)
                                        return
                                    }
                                })                    }
                        })
                    })
                }
    })
        
    }
    
    

    //func
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            profilePicture.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpProfile() {
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        
        let uid = Auth.auth().currentUser?.uid
        databaseRef.child("users").child(uid!).observeSingleEvent(of: .value, with:  { (snapshot) in
            if let dict = snapshot.value as?[String: AnyObject] {
                self.emailEdit.text = dict["Email"] as? String
                if let profileImageURL = dict["pic"] as? String
                {
                    let url = URL(string: profileImageURL)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil{
                            print(error!)
                            return
                        }
                        DispatchQueue.main.async {
                            self.profilePicture.image = UIImage(data: data!)
                        }
                    }).resume()
                }
            }
       
                //create a dictionary of users profile data
                let values = snapshot.value as? NSDictionary
                
                //if there is a url image stored in photo
                if let profileImageURL = values?["pic"] as? String{
                    //using sd_setImage load photo
                    self.profilePicture.setImage(with: URL(string: profileImageURL))
                }
                
                self.surnameEdit.text = values?["lastName"] as? String
                
                
                self.firstnameEdit.text = values?["firstname"] as? String
                
                
                self.emailEdit.text = values?["email"] as? String
            
                self.stateOfResidenceEdit.text = values?["state"] as? String
    })
    
  

   

    /*
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        surnameEdit.becomeFirstResponder()
    }


}
