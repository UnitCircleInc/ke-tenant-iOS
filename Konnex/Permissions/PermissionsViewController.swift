//
//  PermissionsViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-21.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class PermissionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var surrogateTableView: UITableView!
    
    private let surrogateItem = "SurrogateListTableViewCell"
    var surrogateModel = SurrogateModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        surrogateTableView.delegate = self
        surrogateTableView.dataSource = self
        surrogateTableView.register(UINib(nibName: surrogateItem, bundle: nil), forCellReuseIdentifier: surrogateItem)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surrogateModel.surrogateList.count // TODO: replace with number of rows in the data table
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: surrogateItem, for: indexPath) as? SurrogateListTableViewCell else {fatalError("Cell Not Found")}
        
        cell.selectionStyle = .none
        let surrogateItems = surrogateModel.surrogateList[indexPath.row]
        
        if (surrogateItems.photo != nil) {
            cell.configure(image: surrogateItems.photo!, name: surrogateItems.name, timestamp: "")
        } else {
            cell.configure(image: UIImage(named: "image-placeholder")!, name: surrogateItems.name, timestamp: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSurrogate = surrogateModel.surrogateList[indexPath.row]
        
        surrogateModel.surrogate = selectedSurrogate
        print("Surrogate is: ", surrogateModel.surrogate)
        
        if let viewController = storyboard?.instantiateViewController(identifier: "SurrogateDetailsViewController") as? SurrogateDetailsViewController {
            viewController.surrogateModel = surrogateModel
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
