//
//  HomeModel.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-23.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit
import os.log
import Foundation

class HomeModel {
    
    var dataModel = DataModelController()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var keys: [String: [String:Key]] = ["tenant":[:], "surrogate":[:]]
    
    // TODO: set these to the current selected unit's details
    var unitName = "Unit 101"
    var unitLocation = "Xtra Storage - Hamilton, Ontario"
    var unitImage = UIImage(named: "unit_image")
    
    func requestKeys() {
        // clear current keylist
        keys = ["tenant":[:], "surrogate":[:]]
        KeyList.keys = keys
        
        appDelegate.requestKeys()
    }
    
    func newUnitSelected(section : String, key : String, allKeys : [String: [String : Key]]) -> Bool {
        keys = allKeys
        let selectedUnit = keys[section]?[key]
        unitName = selectedUnit!.unit
        unitLocation = selectedUnit!.address
        
        ActiveKey.key = selectedUnit
        print("selected key IS ", ActiveKey.key ?? "<unknown>")
        
        if (section == "surrogate") {
            return true
        } else {
            return false
        }
    }
    
}
