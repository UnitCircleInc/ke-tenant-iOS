//
//  EditSurrogateCompleteViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-24.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class EditSurrogateCompleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editCompleteButton: UIButton!
    
    private let radioButton = "RadioButtonTableViewCell"
    var editSurrogateModel: EditSurrogateModel!
        
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
        
        editCompleteButton.isEnabled = false
        editCompleteButton.setTitleColor(UIColor.gray, for: .disabled)
        
        print(editSurrogateModel.surrogate)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (editSurrogateModel.surrogate.sendEmail == true) {
            // checks email
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
        } else {
            // checks Temporary
            let indexPath = IndexPath(row: 1, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
        }
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
            editCompleteButton.isEnabled = true
        }
    }
    @IBAction func completeButtonTap(_ sender: Any) {
        if selectedRadioButton == 0 {
            // send email
            editSurrogateModel.surrogate.sendEmail = true
        } else {
            // send sms
            editSurrogateModel.surrogate.sendEmail = false
        }
        
        print("New surrogate is: ", editSurrogateModel.surrogate)
        editSurrogateModel.surrogateChanged(surrogate: editSurrogateModel.surrogate)
        self.navigationController?.popToRootViewController(animated: true)
        print("Completed submission of surrogate")
        
        editSurrogateModel.surrogateChanged(surrogate: editSurrogateModel.surrogate)
    }

}
