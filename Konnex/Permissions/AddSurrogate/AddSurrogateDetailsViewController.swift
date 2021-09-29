//
//  AddSurrogateDetailsViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-22.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class AddSurrogateDetailsViewController: UIViewController, ImagePickerDelegate {

    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet var screenTap: UITapGestureRecognizer!
    @IBOutlet weak var nextPageButton: UIButton!
    
    var addSurrogateModel = AddSurrogateModel()
    
    let invalidAlert = UIAlertController(title: "Missing information" , message: "Please fill out all fields with valid information.", preferredStyle: .alert)
    let emailAlert = UIAlertController(title: "Invalid Email" , message: "Please provide a valid email address.", preferredStyle: .alert)
    let phoneAlert = UIAlertController(title: "Invalid Phone Number" , message: "Please provide a valid phone number.", preferredStyle: .alert)
    
    var imagePicker: ImagePicker!
    var surrogateImage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameInput.delegate = self
        self.titleInput.delegate = self
        self.emailInput.delegate = self
        self.phoneInput.delegate = self
        
        addToolBar(textField: nameInput)
        addToolBar(textField: titleInput)
        addToolBar(textField: emailInput)
        addToolBar(textField: phoneInput)
        
        invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        emailAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        phoneAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }

    func didSelect(image: UIImage?) {
        if image == nil {
            self.addImageButton.setImage(UIImage(named: "image-placeholder"), for: .normal)
        }
        self.addImageButton.setImage(image, for: .normal)
        surrogateImage = image
    }
    
    @IBAction func onImageButtonTap(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    // next button will move the cursor to next text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameInput:
            self.titleInput.becomeFirstResponder()
        case self.titleInput:
            self.emailInput.becomeFirstResponder()
        case self.emailInput:
            self.phoneInput.becomeFirstResponder()
        default:
            self.nameInput.becomeFirstResponder()
        }
    }
    
    @IBAction func tapScreen(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func closeKeyboard() {
        view.endEditing(true)
    }
    @IBAction func goToNextPage(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(identifier: "AddSurrogatePage2") as AddSurrogatePermissionsViewController
        
        vc.addSurrogateModel = addSurrogateModel
        
        if nameInput.text == "" || emailInput.text == "" || titleInput.text == "" || phoneInput.text == "" {
            present(invalidAlert, animated: true)
            
        } else if emailInput.text?.isValidEmail == false {
            present(emailAlert, animated: true)
            emailInput.layer.borderColor = UIColor.red.cgColor
            phoneInput.layer.borderWidth = 1.0
            
        } else if phoneInput.text?.isValidPhone == false {
            present(phoneAlert, animated: true)
            phoneInput.layer.borderColor = UIColor.red.cgColor
            phoneInput.layer.borderWidth = 1.0
            
        } else {
            emailInput.layer.borderColor = UIColor.black.cgColor
            phoneInput.layer.borderColor = UIColor.black.cgColor
            
            addSurrogateModel.newSurrogate.photo = surrogateImage
            addSurrogateModel.newSurrogate.name = nameInput.text!
            addSurrogateModel.newSurrogate.title = titleInput.text!
            addSurrogateModel.newSurrogate.email = emailInput.text!
            addSurrogateModel.newSurrogate.phone = phoneInput.text!
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// add keyboard toolbar with "done" button
extension UIViewController: UITextFieldDelegate {
    func addToolBar(textField: UITextField) {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePressed))
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
    @objc func cancelPressed() {
        self.view.endEditing(true)
    }
}

extension String {
    var isValidPhone: Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", PHONE_REGEX)
        return testPhone.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
       return testEmail.evaluate(with: self)
    }
}
