//
//  SurrogateDetailsViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-28.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class SurrogateDetailsViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailPhone: UILabel!
    @IBOutlet weak var accessTimePeriod: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    var surrogateModel: SurrogateModel!
    
    let deleteAlert = UIAlertController(title: "Delete surrogate?", message: "This surrogate will no longer be able to access the unit.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .destructive) {(_) in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (surrogateModel.surrogate.photo != nil) {
            photo.image = surrogateModel.surrogate.photo!
        } else {
            photo.image = UIImage(named: "image-placeholder")!
        }
        
        name.text = surrogateModel.surrogate.name
        emailPhone.text = surrogateModel.surrogate.email + " / " + surrogateModel.surrogate.phone
        
        if (surrogateModel.surrogate.isTemporarySurrogate == true) {
            // TODO: conditional logic based on if start/end times are existent
            accessTimePeriod.text = surrogateModel.surrogate.startDate! + " - " + surrogateModel.surrogate.endDate!
            
        } else {
            accessTimePeriod.text = "Permanent"
        }
    }
    
    @IBAction func editButtonTap(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "EditSurrogatePage1") as! EditSurrogateDetailsViewController
        
        vc.editSurrogateModel = EditSurrogateModel()
        vc.editSurrogateModel.surrogate = surrogateModel.surrogate
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func trashTap(_ sender: Any) {
        present(deleteAlert, animated: true)
    }
}
