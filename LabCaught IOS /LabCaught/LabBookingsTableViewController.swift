//
//  LabBookingsTableViewController.swift
//  LabCaught
//
//  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 26/12/2023.
//

import UIKit

class LabBookingsTableViewController: UITableViewController {
    
    // Outlet for the segmented control to filter bookings
    @IBOutlet weak var segment: UISegmentedControl!
    
    // Array to store filtered bookings based on the logged-in user and selected segment
    var bookings: [booking] = AppData.bookings.filter{$0.medicalService.facility.username == AppData.getLoggedInUsername()}

    // Called when the table view controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Called before the view is added to the view hierarchy
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentChange(segment) // Update bookings list based on the selected segment
    }
    
    // Action handler for the segmented control change
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        // Filter bookings based on the selected segment: upcoming, completed, or cancelled
        if sender.selectedSegmentIndex == 0{
            bookings = AppData.bookings.filter{$0.medicalService.facility.username == AppData.getLoggedInUsername() && $0.status == .upcoming}
        }else if(sender.selectedSegmentIndex == 1){
            bookings = AppData.bookings.filter{$0.medicalService.facility.username == AppData.getLoggedInUsername() && $0.status == .completed}
        }else{
            bookings = AppData.bookings.filter{$0.medicalService.facility.username == AppData.getLoggedInUsername() && $0.status == .cancelled}
        }
        tableView.reloadData() // Reload the table view with the new list of bookings
    }
    
    // MARK: - Table view data source

    // Returns the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Returns the number of rows in a given section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookings.count
    }

    // Configures and returns the cell for a given row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BCell", for: indexPath) as! LabBookingsTableViewCell
        
        let booking = bookings[indexPath.row]
        
        cell.configure(booking: booking) // Configuring the cell with booking data

        return cell
    }

    
    // MARK: - Navigation
    
    // Prepares for the segue to the booking details view controller
    @IBSegueAction func bookingDetails(_ coder: NSCoder, sender: Any?) -> BookingDetailsTableViewController? {
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell)
        else { return nil }
        let booking = bookings[indexPath.row]
        return BookingDetailsTableViewController(coder: coder, booking: booking)
    }
    
    
    // Action handler for unwinding the segue to return to the bookings page
    @IBAction func unwindToLabBookingPage(segue: UIStoryboardSegue) {
    }
    
    
    @IBAction func logOutToMain(_ sender: Any) {
        Alerts.showLogoutConfirmation(on: self) {
            Utility.switchToStoryboard(named: "Main")
        }
    }
    
}
