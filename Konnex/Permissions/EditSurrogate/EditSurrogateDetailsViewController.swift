//
//  EditSurrogateDetailsViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-11-24.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class EditSurrogateDetailsViewController: UIViewController, ImagePickerDelegate {

    @IBOutlet weak var editImageButton: UIButton!
    @IBOutlet weak var editNameInput: UITextField!
    @IBOutlet weak var editTitleInput: UITextField!
    @IBOutlet weak var editEmailInput: UITextField!
    @IBOutlet weak var editPhoneInput: UITextField!
    @IBOutlet weak var editDetailsNextPageButton: UIButton!
    @IBOutlet var screenTap: UITapGestureRecognizer!
    
    var editSurrogateModel : EditSurrogateModel!
    
    let invalidAlert = UIAlertController(title: "Missing information" , message: "Please fill out all fields with valid information.", preferredStyle: .alert)
    let emailAlert = UIAlertController(title: "Invalid Email" , message: "Please provide a valid email address.", preferredStyle: .alert)
    let phoneAlert = UIAlertController(title: "Invalid Phone Number" , message: "Please provide a valid phone number.", preferredStyle: .alert)
    
    var imagePicker: ImagePicker!
    var surrogateImage : UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editNameInput.delegate = self
        self.editTitleInput.delegate = self
        self.editEmailInput.delegate = self
        self.editPhoneInput.delegate = self
        
        addToolBar(textField: editNameInput)
        addToolBar(textField: editTitleInput)
        addToolBar(textField: editEmailInput)
        addToolBar(textField: editPhoneInput)
        
        invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        emailAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        phoneAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        editImageButton.setImage(editSurrogateModel.surrogate.photo, for: .normal)
        editNameInput.text = editSurrogateModel.surrogate.name
        editTitleInput.text = editSurrogateModel.surrogate.title
        editEmailInput.text = editSurrogateModel.surrogate.email
        editPhoneInput.text = editSurrogateModel.surrogate.phone
        
    }
   
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

   func didSelect(image: UIImage?) {
       if image == nil {
           self.editImageButton.setImage(UIImage(named: "image-placeholder"), for: .normal)
       }
       self.editImageButton.setImage(image, for: .normal)
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
       case self.editNameInput:
           self.editTitleInput.becomeFirstResponder()
       case self.editTitleInput:
           self.editEmailInput.becomeFirstResponder()
       case self.editEmailInput:
           self.editPhoneInput.becomeFirstResponder()
       default:
           self.editNameInput.becomeFirstResponder()
       }
   }

   private func closeKeyboard() {
       view.endEditing(true)
   }
   @IBAction func goToNextPage(_ sender: Any) {
       let vc = self.storyboard!.instantiateViewController(identifier: "EditSurrogatePage2") as EditSurrogatePermissionsViewController
       
       vc.editSurrogateModel = editSurrogateModel
       
       if editNameInput.text == "" || editEmailInput.text == "" || editTitleInput.text == "" || editPhoneInput.text == "" {
           present(invalidAlert, animated: true)
           
       } else if editEmailInput.text?.isValidEmail == false {
           present(emailAlert, animated: true)
           editEmailInput.layer.borderColor = UIColor.red.cgColor
           editPhoneInput.layer.borderWidth = 1.0
           
       } else if editPhoneInput.text?.isValidPhone == false {
           present(phoneAlert, animated: true)
           editPhoneInput.layer.borderColor = UIColor.red.cgColor
           editPhoneInput.layer.borderWidth = 1.0
           
       } else {
            editEmailInput.layer.borderColor = UIColor.black.cgColor
            editPhoneInput.layer.borderColor = UIColor.black.cgColor
           
            editSurrogateModel.surrogate.photo = surrogateImage
            editSurrogateModel.surrogate.name = editNameInput.text!
            editSurrogateModel.surrogate.title = editTitleInput.text!
            editSurrogateModel.surrogate.email = editEmailInput.text!
            editSurrogateModel.surrogate.phone = editPhoneInput.text!
            navigationController?.pushViewController(vc, animated: true)
       }
   }
}
