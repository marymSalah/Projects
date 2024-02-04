//
//  Utility.swift
//  LabCaught
//
//  Created by mobileProg on 20/12/2023.
//

import Foundation
import UIKit

// A struct containing utility functions used throughout the app.
struct Utility {
    
    
    // Function to parse a date string into DateComponents.
    // The function expects a date string in the format "dd/MM/yyyy".
    static func parseDateComponents(from dateString: String) -> DateComponents? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // Specifying the expected date format.
        guard let date = dateFormatter.date(from: dateString) else {
            return nil // Returning nil if the date string does not match the format.
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components // Returning the DateComponents extracted from the date.
    }
    
    
    // Function to validate a phone number.
    // It checks if the phone number has exactly 8 digits.
    static func isPhoneNumberCorrect(phoneNumber: String) -> Bool {
            let trimmedPhoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmedPhoneNumber.count == 8 && trimmedPhoneNumber.allSatisfy { $0.isNumber }
        }
    
    // Function to validate a CPR number.
    // It checks if the CPR number has exactly 9 digits.
    static func isCPRCorrect(_ cpr: String) -> Bool {
            let trimmedCpr = cpr.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmedCpr.count == 9 && trimmedCpr.allSatisfy { $0.isNumber }
        }
    
    // check if the password is strong
    static func isPasswordStrong(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    //Invalid Credentials Alert
    static func showInvalidCredentialsAlert(on viewController: UIViewController, usernameTextField: UITextField, passwordTextField: UITextField) {
            Alerts.showAlertWithRetry(on: viewController, title: "Login Error", message: "The provided credentials are incorrect.", retryHandler: {
                passwordTextField.text = ""
                usernameTextField.becomeFirstResponder()
            })
        }

    
    
    //Don't Touch this is the segue
    // Function to switch to a different storyboard.
    static func switchToStoryboard(named name: String) {
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                return
            }
            
            window.rootViewController = initialViewController
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    //for the segue
    
}
    
    
    

