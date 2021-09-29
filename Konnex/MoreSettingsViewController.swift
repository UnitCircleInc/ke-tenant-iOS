//
//  MoreSettingsViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-28.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class MoreSettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let menuItemButton = "MenuItemUITableViewCell"
    
    struct menuItem {
        let name: String
        let image: UIImage
    }
    
    var menuItems: [menuItem] = [
        menuItem(name: "Profile Settings", image: UIImage(named: "menu-settings")!),
        menuItem(name: "Terms and Conditions", image: UIImage(named: "menu-settings")!),
        menuItem(name: "Privacy Policy", image: UIImage(named: "menu-more")!)
//        menuItem(name: "Switch to Manager View", image: UIImage(named: "menu-mode-change")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: menuItemButton, bundle: nil), forCellReuseIdentifier: menuItemButton)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: menuItemButton, for: indexPath) as? MenuItemUITableViewCell else {fatalError("Cell not Found")}
        cell.selectionStyle = .none
        let item = menuItems[indexPath.row]
        
        cell.configure(item.name, image: item.image)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let managerAppBoard = UIStoryboard(name: "ManagerApp", bundle: nil)
//        let vc = managerAppBoard.instantiateViewController(identifier: "managerApp") as UIViewController
        
        if indexPath.row == 0 {
//            self.performSegue(withIdentifier: "showProfileSettings", sender: self)
        }
        
//        switch indexPath.row {
//        case 0:
//            self.performSegue(withIdentifier: "showProfileSettings", sender: self)
//        default:
//            self.navigationController?.popToRootViewController(animated: true)
//            self.navigationController?.setViewControllers([vc], animated: true)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }


        
        
        
        
    }

}
