//
//  TermsandConditionsTableViewController.swift
//  LabCaught
//
//  Created by mobileProg on 27/12/2023.
//

import UIKit

class TermsandConditionsTableViewController: UITableViewController {

    
    @IBOutlet var Termstxt: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable text editing
        Termstxt.isEditable = false
        
        // Seting up the terms and conditions text
        setupTermsAndConditionsText()
    }
    
    // Function to set up the terms and conditions text in the UITextView
    func setupTermsAndConditionsText() {
        let termsText = """
Welcome to LabCaught app! By using our services, you agree to comply with and be bound by the following terms and conditions. Please read the following carefully:

User Agreement:
By using our app, you agree to provide accurate and complete information during the registration process.
You are responsible for maintaining the confidentiality of your account credentials.
You must not use the app for any unlawful or unauthorized purposes.

Lab Partnership:
Labs interested in joining our network must request partnership. by contacting us.
we reserve the right to accept or reject partnership requests.
Once accepted, the lab can manage their tests, packages, and view booking information.

Account Deletion:
Users and labs can request account deletion by contacting the admin.
we will review and process account deletion requests.

Test and Package Management:
Labs can add, edit, or delete tests and packages through their account.
Changes made by labs are subject to review by the admin

Booking Information:
Labs can view upcoming, completed, and cancelled bookings.
Users can book tests through the app.

Clinic Management:
 We reserve the authority to add, edit, or delete clinics from the app.

Limitation of Liability:
We are not liable for any damages or losses resulting from the use of our services.

Changes to Terms:
We reserve the right to modify these terms at any time. Users will be notified of any changes.

Termination:
We reserve the right to terminate accounts for violation of terms or for any other reason.

Privacy Policy
Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information.

Information Collection:
We collect personal information during account creation and app usage.

Use of Information:
We use collected information to provide and improve our services.

3.Security:
We implement security measures to protect your information.

Third-Party Services:
We may use third-party services, and their terms may apply.

Cookies:
We may use cookies for a better user experience.

Sharing Information:
We will share information with labs for booking purposes.

About Us
LabCaught is dedicated to providing a convenient platform for users to book medical tests and for labs to manage their services efficiently. Our mission is to enhance the healthcare experience by connecting users with reliable labs. For inquiries or assistance, please contact us.

Update and Changes
We may update our Terms and Conditions and Privacy Policy periodically. Users will be notified of any changes within the app. Continued use of our services implies acceptance of the updated terms.

Contact Us
For any questions, concerns, or feedback, please contact our support team at [support@labcaught.com] or [+973 17897472]. We strive to provide timely assistance and ensure a seamless experience for our users and partners.
"""
        
        // Set the terms and conditions text in the UITextView
        Termstxt.text = termsText
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Defining the number of sections in the table view
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Defining the number of rows in the section
        return 1
    }




}
