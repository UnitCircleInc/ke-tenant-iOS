//
//  ActivityModel.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-23.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import Foundation
import UIKit

class ActivityModel {
    
    var allActivity: [activity] = []
    var recentActivity: [activity] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var keys: [String: [String : Key]] = ["tenant":[:], "surrogate":[:]]
    
    var dataModel = DataModelController()
    let format = DateFormatter()
    
    
    func setupLogEvents() {
        if ActiveKey.key?.log.count == allActivity.count {
            // do nothing
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            if let lockEvents = ActiveKey.key?.log {
               for event in lockEvents {
                    allActivity.append(activity(name: "Event", status: event.event, timeStamp: formatter.string(from: event.date)))
                    recentActivity.append(activity(name: "Event", status: event.event, timeStamp: formatter.string(from: event.date)))
               }
            }
        }
    }
    
    
    func filterData(appliedFilter: String) {
    //        let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
        
        switch appliedFilter {
            case "24 hours":
                let earlyDate = Calendar.current.date(byAdding: .hour, value: -24, to: Date())
                let earlyDateString = format.string(from: earlyDate!)
                recentActivity = allActivity.filter { ($0).timeStamp > earlyDateString }
                
            case "Past Week":
                let earlyDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
                let earlyDateString = format.string(from: earlyDate!)
                recentActivity = allActivity.filter { ($0).timeStamp > earlyDateString }
                
            case "Past 2 Weeks":
                let earlyDate = Calendar.current.date(byAdding: .day, value: -14, to: Date())
                let earlyDateString = format.string(from: earlyDate!)
                recentActivity = allActivity.filter { ($0).timeStamp > earlyDateString }
                
            case "Past Month":
                let earlyDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
                let earlyDateString = format.string(from: earlyDate!)
                recentActivity = allActivity.filter { ($0).timeStamp > earlyDateString }
                
                // TODO: create case for custom time filters
    //        case "Custom":
    //            self.menuButton.setTitle("Custom", for: .normal)
                
            default:
                recentActivity = allActivity
            }
        print("filtered activity", recentActivity)
    }
}
