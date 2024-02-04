//
//  LoginTableViewController.swift
//  LabCaught
//
//  Created by mobileProg on 10/12/2023.
//

import UIKit

// This class manages the login process.
class LoginTableViewController: UITableViewController {
    
    // Outlets that connect to the username and password text fields in the storyboard.
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Called after the view controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        // here goes Any additional setup after loading the view.
    }
    
    // This function is called when the login button is tapped.
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
        // Checking if the username field is empty.
        guard let username = usernameTextField.text, !username.isEmpty else {
            Alerts.showAlertWithRetry(on: self, title: "Login Error", message: "Username field cannot be empty.", retryHandler: {
                self.usernameTextField.becomeFirstResponder()
            })
            return
        }
        
        // Checking if the password field is empty.
        guard let password = passwordTextField.text, !password.isEmpty else {
            Alerts.showAlertWithRetry(on: self, title: "Login Error", message: "Password field cannot be empty.", retryHandler: {
                self.passwordTextField.becomeFirstResponder()
            })
            return
        }
        
        // Checkin if the username exists in any user list.
            let usernameExists = AppData.patient.contains { $0.username == username } ||
                                 AppData.facilites.contains { $0.username == username } ||
                                 AppData.admins.contains { $0.username == username } ||
                                 AppData.samplePatients.contains { $0.username == username }
            
            // Checking if the entered username and password match a user's credentials.
            let isUserValid = (AppData.patient.first { $0.username == username }?.password == password) ||
                              (AppData.facilites.first { $0.username == username }?.password == password) ||
                              (AppData.admins.first { $0.username == username }?.password == password) ||
                              (AppData.samplePatients.first { $0.username == username }?.password == password)
        
        if isUserValid {
            // Save the logged-in username
            AppData.saveLoggedInUsername(username: username)
            
            // Determine the user type and switch to the appropriate storyboard.
            if AppData.patient.contains(where: { patient in patient.username == username }) ||
                AppData.samplePatients.contains(where: { samplePatient in samplePatient.username == username }) {
                Utility.switchToStoryboard(named: "Paitent")
            } else if AppData.facilites.contains(where: { facility in facility.username == username }) {
                Utility.switchToStoryboard(named: "Lab")
            } else if AppData.admins.contains(where: { admin in admin.username == username }) {
                Utility.switchToStoryboard(named: "Admin")
            }
            
        } else if !usernameExists {
            // Username does not exist, asking user to register
                    Alerts.showAlertWithOptionToRegister(on: self, title: "Registration Required", message: "Username not found. Would you like to register?") {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showRegistration", sender: self)
                        }
            }
        } else {
            // Username exists, but wrong password entered
                   Utility.showInvalidCredentialsAlert(on: self, usernameTextField: usernameTextField, passwordTextField: passwordTextField)
        }
    }
}
