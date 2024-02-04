//
//  RegistrationTableViewController.swift
//  LabCaught
//
//  Created by mobileProg on 13/12/2023.
//

import UIKit


//Registration table view controller to allow new patients to register in the app
class RegistrationTableViewController: UITableViewController {

    // Outlets for the text fields where users enter their personal information.
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var CPRTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!

    // Outlet for the switch to accept terms and conditions.
    @IBOutlet var TermsSwitch: UISwitch!

    // Called after the view controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting a unique tag to the username text field.
        UserNameTextField.tag = 1
        
    }
    
    //this action is called when the save button is tapped
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        
   
        
        
        // Validate that none of the text fields are empty
        guard let firstName = FirstNameTextField.text, !firstName.isEmpty,
              let lastName = LastNameTextField.text, !lastName.isEmpty,
              let dob = DOBTextField.text, !dob.isEmpty,
              let cpr = CPRTextField.text, !cpr.isEmpty,
              let phoneNumber = PhoneNumberTextField.text, !phoneNumber.isEmpty,
              let userName = UserNameTextField.text, !userName.isEmpty,
              let password = PasswordTextField.text, !password.isEmpty,
              let confirmPassword = ConfirmPasswordTextField.text, !confirmPassword.isEmpty else {
           // Show an alert if any field is empty.
                  Alerts.showAlertWithRetry(on: self, title: "Registration Error", message: "Please fill in all fields.", retryHandler: {
                 // Optional retry logic
            })
            return
        }
        
        // Check if the entered passwords match.
        guard password == confirmPassword else {
             // Show an alert if passwords do not match.
            Alerts.showAlertWithRetry(on: self, title: "Password Error", message: "Passwords do not match.", retryHandler: {
                // Optional retry logic for passwords
            })
            return
        }
        
        
        
        // Check if the username is already in use
            let usernameInUse = AppData.patient.contains { $0.username == UserNameTextField.text } ||
                                AppData.facilites.contains { $0.username == UserNameTextField.text } ||
                                AppData.admins.contains { $0.username == UserNameTextField.text } ||
                                AppData.samplePatients.contains { $0.username == UserNameTextField.text }

        
        
        if usernameInUse {
               // Show alert if username is already in use
               Alerts.showAlertWithRetry(on: self, title: "Username Error", message: "Username already in use", retryHandler: { [weak self] in
                   self?.UserNameTextField.text = ""
                   self?.UserNameTextField.becomeFirstResponder()
               })
               return
           }
        
        // Check if the password is strong.
        guard Utility.isPasswordStrong(password) else {
            Alerts.showAlertWithRetry(on: self, title: "Weak Password", message: "Please enter a stronger password. It should have at least 8 characters, including uppercase and lowercase letters, a number, and a special character.", retryHandler: { [weak self] in
                self?.PasswordTextField.text = ""
                self?.ConfirmPasswordTextField.text = ""
                self?.PasswordTextField.becomeFirstResponder()
            })
            return
        }
   
        
        // In RegistrationTableViewController
        if !Utility.isCPRCorrect(CPRTextField.text ?? "") {
            Alerts.showAlertWithRetry(on: self, title: "CPR Error", message: "The entered CPR is incorrect", retryHandler: {
                self.CPRTextField.becomeFirstResponder()
            })
            return
        }

        // Check if the username is already in use.
            if AppData.isUsernameInUse(username: userName) {
                Alerts.showAlertWithRetry(on: self, title: "Username Error", message: "Username already in use", retryHandler: { [weak self] in
                    self?.UserNameTextField.text = ""
                    self?.UserNameTextField.becomeFirstResponder()
                })
                return
            }
      

        // Check the date of birth format correctness.
            guard let dobComponents = Utility.parseDateComponents(from: dob) else {
                Alerts.showAlertWithRetry(on: self, title: "DOB Error", message: "The entered Date of Birth is in an incorrect format. Please use 'dd/MM/yyyy'.", retryHandler: {
                    self.DOBTextField.text = ""
                    self.DOBTextField.becomeFirstResponder()
                })
                return
            }
        
        
        
        
        // Check if the phone number is correct.
            guard Utility.isPhoneNumberCorrect(phoneNumber: phoneNumber) else {
                Alerts.showAlertWithRetry(on: self, title: "Phone Number Error", message: "The phone number is incorrect", retryHandler: {
                    self.PhoneNumberTextField.text = ""
                    self.PhoneNumberTextField.becomeFirstResponder()
                })
                return
            }
        
        
        // Check the terms switch.
            guard TermsSwitch.isOn else {
                Alerts.showAlertWithRetry(on: self, title: "Terms and Conditions", message: "You must agree to the terms and conditions to continue", retryHandler: {
                    self.TermsSwitch.setOn(false, animated: true)
                })
                return
            }
        
        
      
        // All checks passed - add the user
        AppData.addUser(username: userName, password: password, phoneNumber: Int(phoneNumber) ?? 0, firstName: firstName, lastName: lastName, dob: dobComponents, cpr: Int(cpr) ?? 0)

        // Show a confirmation alert for successful registration
        let registrationSuccessAlert = UIAlertController(title: "Registration Successful", message: "You have successfully registered. Please log in.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            // Navigate back to the login screen
            self?.navigationController?.popViewController(animated: true)
        }

        registrationSuccessAlert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(registrationSuccessAlert, animated: true, completion: nil)
        }
        
        
      }
   
    }

