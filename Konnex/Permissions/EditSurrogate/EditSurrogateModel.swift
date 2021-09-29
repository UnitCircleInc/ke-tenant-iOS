//
//  EditSurrogateModel.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-24.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import Foundation
import UIKit

class EditSurrogateModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var surrogate = Surrogate(name: "", title: "", email: "", phone: "", photo: nil, isTemporarySurrogate: false, startDate: "", startTime: "", endDate: "", endTime: "", sendEmail: false)
    
    func surrogateChanged(surrogate: Surrogate) {
        
        // app delegate call
        //        appDelegate.requestSurrogate(lock: lock!, surrogate: sendToText.text!, count: UInt64(validCount!), expiry: UInt64(validToDate!.timeIntervalSince1970))
                
        //        requestSurrogate(lock: String, surrogate: String, count: UInt64, expiry: UInt64)
        
    }
    
}
