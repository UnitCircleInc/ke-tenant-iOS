//
//  ActivityViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-20.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var activityTableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var noActivityLabel: UILabel!
    @IBOutlet weak var nameSubtitle: UILabel!
    @IBOutlet weak var statusSubtitle: UILabel!
    @IBOutlet weak var timeStampSubtitle: UILabel!
    private let activityItem = "ActivityListTableViewCell"

    var dataModel = DataModelController()
    let filterDropdown = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    var activityModel = ActivityModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noActivityLabel.isHidden = true
        
        let dataTBC = tabBarController as! DataTabBarController
        dataModel = dataTBC.dataModel
        print("initial keylist", activityModel.keys)
        
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityTableView.register(UINib(nibName: activityItem, bundle: nil), forCellReuseIdentifier: activityItem)
    
        // dropdown menu actions
        filterDropdown.addAction(UIAlertAction(title:"Past 24 Hours", style: .default) {(_) in
            self.filterData(appliedFilter: "24 hours")
        })
        filterDropdown.addAction(UIAlertAction(title:"Past Week", style: .default) {(_) in
            self.filterData(appliedFilter: "Past Week")
        })
        filterDropdown.addAction(UIAlertAction(title:"Past 2 Weeks", style: .default) {(_) in
            self.filterData(appliedFilter: "Past 2 Weeks")
        })
        filterDropdown.addAction(UIAlertAction(title:"Past Month", style: .default) {(_) in
            self.filterData(appliedFilter: "Past Month")
        })
//        filterDropdown.addAction(UIAlertAction(title:"Custom", style: .default) {(_) in
//            self.menuButton.setTitle("Custom", for: .normal)
//            // apply filters to tableview data for past 2 weeks
//        })
        filterDropdown.addAction(UIAlertAction(title:"Clear Filter", style: .default) {(_) in
            self.filterData(appliedFilter: "Clear")
        })
        filterDropdown.addAction(UIAlertAction(title:"Cancel", style: .cancel) {(_) in })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        activityModel.keys = KeyList.keys
        activityModel.setupLogEvents()
        
        if (activityModel.allActivity.isEmpty) {
            // update UI to show the "no activity" label
            noActivityLabel.isHidden = false
            activityTableView.isHidden = true
            menuButton.isHidden = true
            nameSubtitle.isHidden = true
            statusSubtitle.isHidden = true
            timeStampSubtitle.isHidden = true
        } else {
            noActivityLabel.isHidden = true
            activityTableView.isHidden = false
            menuButton.isHidden = false
            nameSubtitle.isHidden = false
            statusSubtitle.isHidden = false
            timeStampSubtitle.isHidden = false
        }
        
        print("ALL ACTIVITY", activityModel.allActivity)
        activityTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityModel.recentActivity.count // TODO: replace with number of rows retrieved from database
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: activityItem, for: indexPath) as? ActivityListTableViewCell else {fatalError("Cell Not Found")}
        
        cell.selectionStyle = .none
        let activityItems = activityModel.recentActivity[indexPath.row]
        
        cell.configure(nameText: activityItems.name, statusText: activityItems.status, timeStampText: activityItems.timeStamp)
        return cell
    }

    @IBAction func menuTap(_ sender: Any) {
        self.present(filterDropdown, animated: true, completion: nil)
    }
    
    // exists in ActivityModel too, tbd which one is kept
    func filterData(appliedFilter: String) {
        switch appliedFilter {
        case "24 hours":
            self.menuButton.setTitle("Past 24 Hours", for: .normal)
            activityModel.filterData(appliedFilter: "24 hours")
            activityTableView.reloadData()
            
        case "Past Week":
            self.menuButton.setTitle("Past Week", for: .normal)
            activityModel.filterData(appliedFilter: "Past Week")
            activityTableView.reloadData()
            
        case "Past 2 Weeks":
            self.menuButton.setTitle("Past 2 Weeks", for: .normal)
            activityModel.filterData(appliedFilter: "Past 2 Weeks")
            activityTableView.reloadData()
            
        case "Past Month":
            self.menuButton.setTitle("Past Month", for: .normal)
            activityModel.filterData(appliedFilter: "Past Month")
            activityTableView.reloadData()
            
            // TODO: create case for custom time filters
//        case "Custom":
//            self.menuButton.setTitle("Custom", for: .normal)
            
        default:
            self.menuButton.setTitle("Filter By", for: .normal)
            activityModel.filterData(appliedFilter: "")
            activityTableView.reloadData()
        }
    }
    
    func updateKeys(_ keys:[String: [String: Key]]) {
//            os_log(.default, log: viewLogger, "new keys: %{public}s", keys.description)
        activityModel.keys = keys
//        saveKeys()
        // TODOO Fix me self.keys = keys
        DispatchQueue.main.async {
            [weak self] in
//            self?.refreshControl?.endRefreshing()
            self?.activityTableView.reloadData()
        }
    }
}
