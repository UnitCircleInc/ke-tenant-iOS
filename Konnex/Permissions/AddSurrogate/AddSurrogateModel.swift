//
//  AddSurrogateModel.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-23.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import Foundation
import UIKit

class AddSurrogateModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var newSurrogate = Surrogate(name: "", title: "", email: "", phone: "", photo: nil, isTemporarySurrogate: false, startDate: "", startTime: "", endDate: "", endTime: "", sendEmail: false)
    
    
    
    func addNewSurrogate(surrogate: Surrogate) {
        
        // app delegate call 
        
    }
    
}



