//
//  AddSurrogatePermissionsViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-20.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

struct Permissions {
    let name: String
    var selected: Bool
}

class AddSurrogatePermissionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var startOptionalLabel: UILabel!
    @IBOutlet weak var endOptionalLabel: UILabel!
    @IBOutlet weak var nextPageButton: UIButton!
    
    var newSurrogate: Surrogate = Surrogate(name: "", title: "", email: "", phone: "", isTemporarySurrogate: false, sendEmail: false)
    
    var addSurrogateModel: AddSurrogateModel!
    
    private let radioButton = "RadioButtonTableViewCell"
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    var optionSelected = false
    
    let invalidAlert = UIAlertController(title: "Missing information" , message: "Please fill out all fields with valid information.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        
        addToolBar(textField: startDate)
        addToolBar(textField: startTime)
        addToolBar(textField: endDate)
        addToolBar(textField: endTime)
        
        invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        setupDatePickers()
        hideSetTime()
    }
    
    func setupTableView() {
//        tableView.register(RadioButtonTableViewCell.self, forCellReuseIdentifier: radioButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: radioButton, bundle: nil), forCellReuseIdentifier: radioButton)
        view.addSubview(tableView)
    }
    
    var radioButtonPermissions: [Permissions] = [
        Permissions(name: "Temporary", selected: false),
        Permissions(name: "Permanent", selected: false)
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
        // TODO:  count the number of surrogates
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: radioButton, for: indexPath) as? RadioButtonTableViewCell else {fatalError("Cell Not Found")}
        
        cell.selectionStyle = .none
        let radioButtons = radioButtonPermissions[indexPath.row]
        
        let currentIndex = indexPath.row
        let selected = currentIndex == selectedRadioButton
        
        cell.configure(radioButtons.name)
        cell.isSelected(selected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSelectedIndex(indexPath.row)
        if indexPath.row == 0 {
            showSetTime()
            optionSelected = true
            newSurrogate.isTemporarySurrogate = true
        } else {
            hideSetTime()
            optionSelected = true
            newSurrogate.isTemporarySurrogate = false
        }
    }
    
    private func hideSetTime() {
        startDate.isHidden = true
        startTime.isHidden = true
        endDate.isHidden = true
        endTime.isHidden = true
        startOptionalLabel.isHidden = true
        endOptionalLabel.isHidden = true
    }
    
    private func showSetTime() {
        startDate.isHidden = false
        startTime.isHidden = false
        endDate.isHidden = false
        endTime.isHidden = false
        startOptionalLabel.isHidden = false
        endOptionalLabel.isHidden = false
    }
    
    func setupDatePickers() {
        
        // TODO: change date format to seconds since unix epoch
        // TODO: set max date to the expiry
        let  currentDate = Date()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        timeFormatter.timeStyle = DateFormatter.Style.short
        
        let startDatePicker = UIDatePicker()
        startDatePicker.datePickerMode = .date
        startDatePicker.minimumDate = currentDate
        startDatePicker.addTarget(self, action: #selector(self.startDatePicked), for: .valueChanged)
        startDate.inputView = startDatePicker
       
        let endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = currentDate
        endDatePicker.addTarget(self, action: #selector(self.endDatePicked), for: .valueChanged)
        endDate.inputView = endDatePicker
        
        let startTimePicker = UIDatePicker()
        startTimePicker.datePickerMode = .time
        startTimePicker.addTarget(self, action: #selector(self.startTimePicked), for: .valueChanged)
        startTime.inputView = startTimePicker
        
        let endTimePicker = UIDatePicker()
        endTimePicker.datePickerMode = .time
        endTimePicker.addTarget(self, action: #selector(self.endTimePicked), for: .valueChanged)
        endTime.inputView = endTimePicker
        
    }
    
    @objc func startDatePicked(datePicker: UIDatePicker) {
        startDate.text = dateFormatter.string(from: datePicker.date)
        newSurrogate.startDate = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func endDatePicked(datePicker: UIDatePicker) {
        endDate.text = dateFormatter.string(from: datePicker.date)
        newSurrogate.endDate = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func startTimePicked(datePicker: UIDatePicker) {
        startTime.text = timeFormatter.string(from: datePicker.date)
        newSurrogate.startTime = timeFormatter.string(from: datePicker.date)
    }
    
    @objc func endTimePicked(datePicker: UIDatePicker) {
        endTime.text = timeFormatter.string(from: datePicker.date)
        newSurrogate.endTime = timeFormatter.string(from: datePicker.date)
    }

    @IBAction func goToNextPage(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(identifier: "AddSurrogatePage3") as AddSurrogateCompleteViewController
        
        if optionSelected == false {
            present(invalidAlert, animated: true)
        } else {
            // set the model in the new VC
            vc.addSurrogateModel = addSurrogateModel
            
            addSurrogateModel.newSurrogate.isTemporarySurrogate = newSurrogate.isTemporarySurrogate
            if (newSurrogate.startDate != nil) {addSurrogateModel.newSurrogate.startDate = newSurrogate.startDate }
            if (newSurrogate.startTime != nil) {addSurrogateModel.newSurrogate.startTime = newSurrogate.startTime}
            if (newSurrogate.endDate != nil) {addSurrogateModel.newSurrogate.endDate = newSurrogate.endDate}
            if (newSurrogate.endTime != nil) {addSurrogateModel.newSurrogate.endTime = newSurrogate.endTime}
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
