//
//  SurrogateModel.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-25.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import Foundation
import UIKit

class SurrogateModel {
    
    // temp data
    var surrogateList: [Surrogate] = [
        Surrogate(name: "Michael", title: "Friend", email: "michael@konnex.com", phone: "6477856487", photo: UIImage(named: "permissions_person")!, isTemporarySurrogate: false, startDate: nil, startTime: nil, endDate: nil, endTime: nil, sendEmail: true),
        Surrogate(name: "Justin", title: "Coworker", email: "justin@place.com", phone: "9959959995", photo: UIImage(named: "image-placeholder"), isTemporarySurrogate: true, startDate: "11/25/2020", startTime: nil, endDate: "11/30/2020", endTime: nil, sendEmail: true)
    ]
    
    var surrogate = Surrogate(name: "", title: "", email: "", phone: "", photo: nil, isTemporarySurrogate: false, startDate: "", startTime: "", endDate: "", endTime: "", sendEmail: false)

    // need to call a 
    
    
}
