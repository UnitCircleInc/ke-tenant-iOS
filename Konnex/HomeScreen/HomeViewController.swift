//
//  HomeViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-16.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit
import os.log
let viewLogger = OSLog(subsystem: "com.konnexenterprises.Konnex", category: "View")

class HomeViewController: UIViewController, ChangeViewControllerDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var unitImageView: UIImageView!
    
    @IBOutlet weak var unitNameLabel: UILabel!
    @IBOutlet weak var unitLocationLabel: UILabel!
    @IBOutlet weak var unlockInstructions: UILabel!
    
    @IBOutlet weak var changeUnitButton: UIButton!
    
    var homeModel: HomeModel!
    
    let unlockAlert = UIAlertController(title: "Unit unlocked successfully", message: "Remember to manually lock before leaving", preferredStyle: .alert)
    let lockAlert = UIAlertController(title: "Unit has been locked successfully", message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeModel = HomeModel()
        
        // initial assignment of activekey
        if(homeModel.keys.isEmpty) {
            // if no key, no active key
            ActiveKey.key = nil
            ActiveKey.keyType = ""
            ActiveKey.dictKey = ""
            
        } else if(homeModel.keys["Tenant"] != nil) {
            ActiveKey.keyType = "Tenant"
            // Fetch a dictionary key and value(KEY) pair and assign it to the Activekey
            ActiveKey.dictKey = homeModel.keys[ActiveKey.keyType]!.keys.first!
            ActiveKey.key = homeModel.keys[ActiveKey.keyType]!.values.first!
            
        } else if(homeModel.keys["Surrogate"] != nil){
            ActiveKey.keyType = "Surrogate"
            ActiveKey.dictKey = homeModel.keys[ActiveKey.keyType]!.keys.first!
            ActiveKey.key = homeModel.keys[ActiveKey.keyType]!.values.first!
            
        } else {
            ActiveKey.key = nil
        }
        
        // unlock alert
        unlockAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // lock alert
        lockAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
//        showLockButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        unitImageView.image = homeModel.unitImage
        unitNameLabel.text = homeModel.unitName
        unitLocationLabel.text = homeModel.unitLocation
    }

    @IBAction func changeUnitTap(_ sender: UIButton) {
        let changeVC = self.storyboard!.instantiateViewController(identifier: "changeUnitViewController") as ChangeUnitViewController
        changeVC.delegate = self
        
        // request new keys - need to check if this is valid as the call goes through on the change view controller
        homeModel.requestKeys() // possible this fails due to appdelegate view not being assigned
        
        self.present(changeVC, animated: true, completion: nil)
    }
    
    // logic for showing/hiding text currently of home screen text
//    @IBAction func onTap(_ sender: UIButton) {
//        // presenting alert needs to be triggered by a bluetooth ping saying that the lock has unlocked
//        present(unlockAlert, animated: true)
//        unitIsLocked = false
//        showLockButton()
//    }
//    @IBAction func lockTap(_ sender: Any) {
//        present(lockAlert, animated: true)
//        unitIsLocked = true
//        showLockButton()
//    }
//
//    func showLockButton() {
//        if unitIsLocked {
//            lockButton.isHidden = true
//            unlockInstructions.isHidden = false
//        } else {
//            lockButton.isHidden = false
//            unlockInstructions.isHidden = true
//        }
//    }
    
    func newUnitChosen(section : String, key : String, allKeys : [String: [String : Key]]) {
        // need to validate this
        let isSurrogate = homeModel.newUnitSelected(section: section, key: key, allKeys: allKeys)
        
        if isSurrogate == true {
            self.tabBarController!.tabBar.isHidden = true
            print("user is surrogate for this unit")
        } else {
            self.tabBarController!.tabBar.isHidden = false
            print("user is tenant for this unit")
        }
        
        unitNameLabel.text = homeModel.unitName
        unitLocationLabel.text = homeModel.unitLocation
    }
}

