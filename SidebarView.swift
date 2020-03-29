//
//  SidebarView.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 11/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
//import SDWebImage

protocol SidebarViewDelegate: class {
    func sidebarDidSelectRow(row: Row)
}

enum Row: String {
    case nearestATMs
    case editProfile
    case history
    case subscription
    case settings
    case help
    case about
    case signOut
    case none
    
    init(row: Int) {
        switch row {
        case 0: self = .nearestATMs
        case 1: self = .editProfile
        case 2: self = .history
        case 3: self = .subscription
        case 4: self = .settings
        case 5: self = .help
        case 6: self = .about
        case 7: self = .signOut
        default: self = .none
        }
    }
}

class SidebarView: UIView, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    
    var titleArr = [String]()
    
    weak var delegate: SidebarViewDelegate?
    
    let databaseRef = Database.database().reference(fromURL: "https://sprylocator.firebaseio.com/")
    let storageRef = Storage.storage().reference()
    
    let uid = Auth.auth().currentUser?.uid
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        self.clipsToBounds=true
        
        let uid = Auth.auth().currentUser?.uid
        databaseRef.child("users").child(uid!).observeSingleEvent(of: .value, with:  { (snapshot) in
            
            let val = snapshot.value as? NSDictionary
            self.titleArr.insert("Hi " + (val?["lastName"] as? String)!, at: 0)
        })
            
            
        titleArr = ["Find nearest ATMs ", "History", "Subscription", "Settings", "Help", "About", "Sign Out"]
        
        setupViews()
        
        myTableView.delegate=self
        myTableView.dataSource=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView=UIView()
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        myTableView.allowsSelection = true
        myTableView.bounces=false
        myTableView.showsVerticalScrollIndicator=false
        myTableView.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        databaseRef.child("users").child(uid!).observeSingleEvent(of: .value, with:  { (snapshot) in
            
            let values = snapshot.value as? NSDictionary
            if let profileImageURL = values?["pic"] as? String {
        if indexPath.row == 0  {
            cell.backgroundColor=UIColor(red: 0/255, green: 32/255, blue: 63/255, alpha: 1.0)
            let cellImg: UIImageView!
            cellImg = UIImageView(frame: CGRect(x: 15, y: 10, width: 80, height: 80))
            cellImg.layer.cornerRadius = 40
            cellImg.layer.masksToBounds=true
            cellImg.contentMode = .scaleAspectFill
            cellImg.layer.masksToBounds=true
            cellImg.setImage(with: URL(string: profileImageURL))
            cell.addSubview(cellImg)
            
            
            let cellLbl = UILabel(frame: CGRect(x: 110, y: cell.frame.height/2-15, width: 250, height: 30))
            cell.addSubview(cellLbl)
            cellLbl.text = self.titleArr[indexPath.row]
            cellLbl.font=UIFont.systemFont(ofSize: 20)
            cellLbl.textColor=UIColor.white
        } else {
            cell.textLabel?.text=self.titleArr[indexPath.row]
            cell.textLabel?.textColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                }
            }
        })
        return cell
    }

    func takePhoto(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            var picker = UIImagePickerController()
            picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = UIImagePickerControllerSourceType.camera
            var mediaTypes: Array<AnyObject>
            picker.allowsEditing = true
        }
        else{
            NSLog("No Camera.")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sidebarDidSelectRow(row: Row(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    func setupViews() {
        self.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        myTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        myTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        myTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let myTableView: UITableView = {
        let table=UITableView()
        table.translatesAutoresizingMaskIntoConstraints=false
        return table
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



