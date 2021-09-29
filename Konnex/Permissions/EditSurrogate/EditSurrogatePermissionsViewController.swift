//
//  EditSurrogatePermissionsViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-24.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class EditSurrogatePermissionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editStartDate: UITextField!
    @IBOutlet weak var editStartTime: UITextField!
    @IBOutlet weak var editEndDate: UITextField!
    @IBOutlet weak var editEndTime: UITextField!
    @IBOutlet weak var editStartOptionalLabel: UILabel!
    @IBOutlet weak var editEndOptionalLabel: UILabel!
    @IBOutlet weak var editPermissionsNextPageButton: UIButton!

    var editSurrogate: Surrogate = Surrogate(name: "", title: "", email: "", phone: "", isTemporarySurrogate: false, sendEmail: false)
        
    var editSurrogateModel: EditSurrogateModel!
    
    private let radioButton = "RadioButtonTableViewCell"
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    var optionSelected = false
    
    let invalidAlert = UIAlertController(title: "Missing information" , message: "Please fill out all fields with valid information.", preferredStyle: .alert)
    
    let temporaryMissingAlert = UIAlertController(title: "Missing information" , message: "You must list a start and end date for a temporary surrogate.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        
        addToolBar(textField: editStartDate)
        addToolBar(textField: editStartTime)
        addToolBar(textField: editEndDate)
        addToolBar(textField: editEndTime)
        
        invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        temporaryMissingAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        editSurrogate = editSurrogateModel.surrogate
        
        setupDatePickers()
        hideSetTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (editSurrogateModel.surrogate.isTemporarySurrogate == true) {
            // checks Temporary
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
            
            editStartDate.text = editSurrogateModel.surrogate.startDate
            editEndDate.text = editSurrogateModel.surrogate.endDate
            
            if (editSurrogateModel.surrogate.startTime != nil) { editStartTime.text = editSurrogateModel.surrogate.startTime }
            if (editSurrogateModel.surrogate.endTime != nil) { editEndTime.text = editSurrogateModel.surrogate.endTime }
        } else {
            // checks Permanent
            let indexPath = IndexPath(row: 1, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
        }
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
            editSurrogate.isTemporarySurrogate = true
        } else {
            hideSetTime()
            optionSelected = true
            editSurrogate.isTemporarySurrogate = false
            editSurrogate.startDate = nil
            editSurrogate.startTime = nil
            editSurrogate.endDate = nil
            editSurrogate.endTime = nil
        }
    }
    
    private func hideSetTime() {
        editStartDate.isHidden = true
        editStartTime.isHidden = true
        editEndDate.isHidden = true
        editEndTime.isHidden = true
        editStartOptionalLabel.isHidden = true
        editEndOptionalLabel.isHidden = true
    }
    
    private func showSetTime() {
        editStartDate.isHidden = false
        editStartTime.isHidden = false
        editEndDate.isHidden = false
        editEndTime.isHidden = false
        editStartOptionalLabel.isHidden = false
        editEndOptionalLabel.isHidden = false
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
        editStartDate.inputView = startDatePicker
       
        let endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = currentDate
        endDatePicker.addTarget(self, action: #selector(self.endDatePicked), for: .valueChanged)
        editEndDate.inputView = endDatePicker
        
        let startTimePicker = UIDatePicker()
        startTimePicker.datePickerMode = .time
        startTimePicker.addTarget(self, action: #selector(self.startTimePicked), for: .valueChanged)
        editStartTime.inputView = startTimePicker
        
        let endTimePicker = UIDatePicker()
        endTimePicker.datePickerMode = .time
        endTimePicker.addTarget(self, action: #selector(self.endTimePicked), for: .valueChanged)
        editEndTime.inputView = endTimePicker
    }
    
    @objc func startDatePicked(datePicker: UIDatePicker) {
        editStartDate.text = dateFormatter.string(from: datePicker.date)
        editSurrogate.startDate = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func endDatePicked(datePicker: UIDatePicker) {
        editEndDate.text = dateFormatter.string(from: datePicker.date)
        editSurrogate.endDate = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func startTimePicked(datePicker: UIDatePicker) {
        editStartTime.text = timeFormatter.string(from: datePicker.date)
        editSurrogate.startTime = timeFormatter.string(from: datePicker.date)
    }
    
    @objc func endTimePicked(datePicker: UIDatePicker) {
        editEndTime.text = timeFormatter.string(from: datePicker.date)
        editSurrogate.endTime = timeFormatter.string(from: datePicker.date)
    }

    @IBAction func goToNextPage(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(identifier: "EditSurrogatePage3") as EditSurrogateCompleteViewController
        
        if optionSelected == false {
            present(invalidAlert, animated: true)
        } else if (editSurrogate.isTemporarySurrogate == true && (editSurrogate.startDate == nil || editSurrogate.endDate == nil)){
            present(temporaryMissingAlert, animated: true)
        } else {
            // set the model in the new VC
            vc.editSurrogateModel = editSurrogateModel
            
            editSurrogateModel.surrogate.isTemporarySurrogate = editSurrogate.isTemporarySurrogate
            editSurrogateModel.surrogate.startDate = editSurrogate.startDate
            editSurrogateModel.surrogate.startTime = editSurrogate.startTime
            editSurrogateModel.surrogate.endDate  = editSurrogate.endDate
            editSurrogateModel.surrogate.endTime = editSurrogate.endTime
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    

}
