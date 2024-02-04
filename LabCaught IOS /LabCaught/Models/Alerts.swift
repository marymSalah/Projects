//
//  Alerts.swift
//  LabCaught
//
//  Created by mobileProg on 10/12/2023.
//

import UIKit

// A class dedicated to managing alert presentations in the app.
class Alerts {
    // Static method to show an alert with a retry option on a view controller.
    static func showAlertWithRetry(on viewController: UIViewController, title: String, message: String, retryHandler: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Try Again", style: .default) { _ in retryHandler()
            
        }
        
        alert.addAction(retryAction)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
     // Method to validate a phone number format.
    func isPhoneNumberCorrect(phoneNumber: String) -> Bool {
        let trimmedPhoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedPhoneNumber.count == 8 && trimmedPhoneNumber.allSatisfy { $0.isNumber }
    }
    
    //to show alert with the option to register
    static func showAlertWithOptionToRegister(on viewController: UIViewController, title: String, message: String, registerHandler: @escaping () -> Void) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let registerAction = UIAlertAction(title: "Register", style: .default) { _ in
               registerHandler()
           }
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

           alert.addAction(registerAction)
           alert.addAction(cancelAction)
           DispatchQueue.main.async {
               viewController.present(alert, animated: true, completion: nil)
           }
       }
    
    
    // Method to validate a CPR number format.
    func isCPRCorrect(_ cpr: String) -> Bool {
        let trimmedCpr = cpr.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedCpr.count == 9 && trimmedCpr.allSatisfy { $0.isNumber }
    }
    
    // Static method to display an alert if a username is already in use.
    static func showUsernameInUseAlertIfNecessary(for username: String, on viewController: UIViewController, isUsernameInUse: () -> Bool, retryHandler: @escaping () -> Void) {
        if isUsernameInUse() {
            showAlertWithRetry(on: viewController, title: "Username Error", message: "Username already in use", retryHandler: retryHandler)
        }
    }
    
    static func showLogoutConfirmation(on viewController: UIViewController, confirmHandler: @escaping () -> Void) {
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
                confirmHandler()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            DispatchQueue.main.async {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
    
    
}

extension UIViewController {
    
    func confirmation(title: String, message: String?, confirmHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Yes", style: .default) { action in
            confirmHandler()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func error(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

enum AlertTitle: String {
    case DeleteConfirm = "Delete Confirmation"
    case ErrorOccurred = "Error Occurred"
}

enum AlertMessage: String {
    case DeleteConfirm = "Are you sure you want to continue deletion?"
    case UserDeleteNotAllowed = "Cannot delete user, as they are part of one or more courses"
}

extension UIViewController{
    func confirmation(title:String, message:String, confirmHandler: @escaping ()-> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "yes", style: .default){
            action in confirmHandler()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert,animated: true)
    }
}
