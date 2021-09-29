//
//  DataModelController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-08-13.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import Foundation
import UIKit

struct Surrogate {
    var name: String
    var title: String
    var email: String
    var phone: String
    var photo: UIImage?
    var isTemporarySurrogate: Bool
    var startDate: String?
    var startTime: String?
    var endDate: String?
    var endTime: String?
    var sendEmail: Bool
}

struct activity {
    var name: String
    var status: String
    var timeStamp: String
}

struct Key: Codable {
    var key: Data
    var lock_pk: String      // Needed for scanning
    var kind: String         // Not used
    var description: String  // Site description - bascially company name
    var address: String      // Site address
    var unit: String         // The unit "name" at the site
    var status: String       // Current status - derived locally - but could also be updated by server
    var log: [KeyLogItem]
}

struct KeyLogItem: Codable {
    var date: Date
    var event: String
}

enum Sections: Int {
    case Tenant = 0
    case Surrogate = 1
    var description: String {
        switch self {
        case .Tenant: return "tenant"
        case .Surrogate: return "surrogate"
        }
    }
}

struct KeyList {
    static var keys : [String: [String : Key]] = ["tenant":[:], "surrogate":[:]]
}

struct ActiveKey {
    static var dictKey = ""
    static var keyType = "" // "tenant" or "surrogate"
    static var key : Key?
}

// colour constants
let konnexBlue = UIColor(red: 14.0/255.0, green: 70.0/255.0, blue: 161.0/255.0, alpha: 1)
let konnexGray = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)


class DataModelController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func update() {
        appDelegate.requestKeys()
    }
}
