//
//  ChangeUnitViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-23.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit
import os.log

protocol ChangeViewControllerDelegate {
    func newUnitChosen(section : String, key : String, allKeys : [String: [String : Key]])
}

class ChangeUnitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate : ChangeViewControllerDelegate!
    
    private var dataController: DataModelController = DataModelController()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var keys: [String: [String : Key]] = ["tenant":[:], "surrogate":[:]]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.view = self
        tableView.delegate = self
        tableView.dataSource = self
    
        appDelegate.requestKeys()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // tenant and surrogate
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let map = ["tenant": "Tenant", "surrogate": "Surrogate"]
        return map[Sections(rawValue: section)!.description]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = (Sections(rawValue: section)?.description)!
        return keys[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unitCell", for: indexPath)
        let section = (Sections(rawValue: indexPath.section)?.description)!
        let sortedKeys = keys[section]!.keys.sorted()
        
        let key = sortedKeys[indexPath.row]
        cell.textLabel?.text = keys[section]![key]?.unit
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = (Sections(rawValue: indexPath.section)?.description)!
        let sortedKeys = keys[section]!.keys.sorted()
        
        let selectedUnit = sortedKeys[indexPath.row]
        
        ActiveKey.dictKey = selectedUnit
        ActiveKey.keyType = section
        ActiveKey.key = keys[section]![selectedUnit]
        
        KeyList.keys = keys

        delegate?.newUnitChosen(section: section, key: selectedUnit, allKeys: keys)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateKeys(_ keys:[String: [String: Key]]) {
        os_log(.default, log: viewLogger, "new keys: %{public}s", keys.description)
        self.keys = keys
//        saveKeys()
        // TODOO Fix me self.keys = keys
        DispatchQueue.main.async {
            [weak self] in
//            self?.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
    }
}
