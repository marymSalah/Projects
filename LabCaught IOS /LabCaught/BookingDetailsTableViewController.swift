//
//  BookingDetailsTableViewController.swift
//  LabCaught
//
//  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 27/12/2023.
//

import UIKit

class BookingDetailsTableViewController: UITableViewController {
    
    // Outlets for displaying booking details on the screen.
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var cprLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var bookingDateLbl: UILabel!
    @IBOutlet weak var testPackageNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var instructionsLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    // Outlets for managing booking status and action buttons.
    @IBOutlet weak var buttonCell: UITableViewCell!
    @IBOutlet weak var statusCell: UITableViewCell!
    @IBOutlet weak var statusLbl: UILabel!
    
    // Variable to store the booking details
    var booking: booking?
    
    // Custom initializer with a booking parameter
    required init?(coder: NSCoder, booking: booking) {
        self.booking = booking
        super.init(coder: coder)
    }
    
    // Standard initializer.
    required init?(coder: NSCoder) {
        self.booking = nil
        super.init(coder: coder)
    }
    
    // This method is called when the table view controller’s view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // Method called before the view is added to the view hierarchy
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Populates the UI with the booking details
        filling()
    }
    
    // Action for cancelling a booking. it shows a confirmation dialog
    @IBAction func cancelBooking(_ sender: Any) {
        // Alert to confirm booking cancellation.
        let alert = UIAlertController(title: "Cancel Booking",
                                          message: "Are you sure you want to cancel this booking?",
                                          preferredStyle: .alert)
        // Actions for the alert
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                // Updates the booking status to cancelled
                AppData.editBookingStatus(booking: self.booking!, status: .cancelled)
            }

            alert.addAction(cancelAction)
            alert.addAction(confirmAction)

            present(alert, animated: true, completion: nil)
    }
    
    // Action for marking a booking as complete.
    @IBAction func completeBooking(_ sender: Any) {
        // Alert to confirm completion of booking.
        let alert = UIAlertController(title: "Complete Booking",
                                          message: "Are you sure you want to complete this booking?",
                                          preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
                AppData.editBookingStatus(booking: self.booking!, status: .completed)
                self.performSegue(withIdentifier: "unwindToLabBokingPage", sender: self)
            }

            alert.addAction(cancelAction)
            alert.addAction(confirmAction)

            present(alert, animated: true, completion: nil)
    }
    
    // Function to populate UI with booking details
    func filling(){
        // Update UI based on booking status
        if let bookingStatus = booking?.status {
                switch bookingStatus {
                case .upcoming:
                    statusCell.isHidden = true
                    buttonCell.isHidden = false
                case .completed:
                    buttonCell.isHidden = true
                    statusCell.isHidden = false
                    statusLbl.text = "APPOINTMENT COMPLETED!"
                    
                default:
                    buttonCell.isHidden = true
                    statusCell.isHidden = false
                    statusLbl.text = "APPOINTMENT CANCELED!"
                }
            }
        
        // Set patient details in the UI
        if let firstName = booking?.patient.firstName, let lastName = booking?.patient.lastName {
            patientNameLbl.text = firstName + lastName
        }
        
        if let CPR = booking?.patient.CPR {
            cprLbl.text = String(CPR)
        }
        
        if let phone = booking?.patient.phoneNumber {
            phoneLbl.text = String(phone)
        }
        // Set booking details in the UI
        if let bookingDate = booking?.booking_date {
            let calendar = Calendar.current
            let date = calendar.date(from: bookingDate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: date!)
            bookingDateLbl.text = dateString
        }
        
        if let testPackageName = booking?.medicalService.name {
            testPackageNameLbl.text = testPackageName
        }
        
        if let price = booking?.medicalService.cost {
            priceLbl.text = price + " BHD"
        }
        
        if let instructions = booking?.medicalService.insrtuctions {
            instructionsLbl.text = instructions
        }
        
        if let description = booking?.medicalService.describtion {
            descriptionLbl.text = description
        }
    }
    
    



}
