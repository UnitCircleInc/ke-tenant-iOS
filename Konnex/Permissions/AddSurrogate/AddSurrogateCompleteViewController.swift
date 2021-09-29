//
//  AddSurrogateCompleteViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-21.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

struct NotifyMethod {
    let method: String
    var selected: Bool
}

class AddSurrogateCompleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    private let radioButton = "RadioButtonTableViewCell"
    
    var addSurrogateModel: AddSurrogateModel!
    
    var validToDate: Date!
    var validCount: Int!
    var lock: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: radioButton, bundle: nil), forCellReuseIdentifier: radioButton)
        view.addSubview(tableView)
        
        completeButton.isEnabled = false
        completeButton.setTitleColor(UIColor.gray, for: .disabled)
        
        print(addSurrogateModel.newSurrogate)
    }

    var radioButtonMethods: [NotifyMethod] = [
        NotifyMethod(method: "Email", selected: false),
        NotifyMethod(method: "SMS", selected: false)
    ]
    
    private var selectedRadioButton: Int? {
        didSet{
            tableView.reloadData()
        }
    }
    
    private func updateSelectedIndex(_ index: Int) {
        selectedRadioButton = index
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: radioButton, for: indexPath) as? RadioButtonTableViewCell else {fatalError("Cell Not Found")}
        
        cell.selectionStyle = .none
        let radioButtons = radioButtonMethods[indexPath.row]
        
        let currentIndex = indexPath.row
        let selected = currentIndex == selectedRadioButton

        cell.configure(radioButtons.method)
        cell.isSelected(selected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSelectedIndex(indexPath.row)
        
        if selectedRadioButton == 0 || selectedRadioButton == 1{
            // enable complete button
            completeButton.isEnabled = true
        }
    }
    @IBAction func completeButtonTap(_ sender: Any) {
        if selectedRadioButton == 0 {
            // send email
            addSurrogateModel.newSurrogate.sendEmail = true
        } else {
            // send sms
            addSurrogateModel.newSurrogate.sendEmail = false
        }
        
        print("New surrogate is: ", addSurrogateModel.newSurrogate)
        addSurrogateModel.addNewSurrogate(surrogate: addSurrogateModel.newSurrogate)
        self.navigationController?.popToRootViewController(animated: true)
        print("Completed submission of surrogate")
        
        
        _ = UIApplication.shared.delegate as! AppDelegate
        //        appDelegate.requestSurrogate(lock: lock!, surrogate: sendToText.text!, count: UInt64(validCount!), expiry: UInt64(validToDate!.timeIntervalSince1970))
        
//        requestSurrogate(lock: String, surrogate: String, count: UInt64, expiry: UInt64)
    }
}
