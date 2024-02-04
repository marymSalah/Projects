//
//  ContactUsTableViewController.swift
//  LabCaught
//
//  Created by mobileProg on 27/12/2023.
//

import UIKit

class ContactUsTableViewController: UITableViewController {

    
    @IBOutlet var ContactUsTxt: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disabling text editing
        ContactUsTxt.isEditable = false
        
        // Seting up the contact information text
        setupContactInformationText()
        
    }

    // Function to set up the contact information text in the UITextView
        func setupContactInformationText() {
            let contactInfoText = """
            At LabCaught, we understand that forgetting your password can be frustrating. We're here to help you regain access to your account. If you're experiencing any issues with your password, please reach out to our support team for prompt assistance.

            Contact Information:
            Email: support@labcaught.com
            Phone: +973 17897472
            Working Hours: 9 AM - 6 PM

            How to Recover Your Password:
            If you've forgotten your password, follow these steps:
            Email Support:
            Send an email to support@labcaught.com with the subject line "Password Recovery Request."
            Include Required Information:
            In your email, please include the following information to expedite the process:
            Your full name
            Username or CPR
            Registered email address
            Any additional details that may help us verify your identity
            Verification Process:
            Our support team will review your request and may contact you for additional verification if needed.
            Password Reset:
            Once your identity is verified, we will assist you in resetting your password.

            General Inquiries:
            For general inquiries, feedback, or any other assistance, feel free to contact us using the same email address and phone number provided above.
            We Are Here to Help:

            LabCaught is committed to providing excellent customer service. Our support team is dedicated to assisting you with any issues you may encounter. Please allow up to 7 working days for a response during our working hours.
            Thank you for choosing LabCaught for your medical testing needs. We appreciate your trust in our services.
            """
            
            // Seting the contact information text in the UITextView
            ContactUsTxt.text = contactInfoText
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
