//
//  patientBookingTableViewController.swift
//  LabCaught
//
//  Created by Maryam Salah Hashem Adnan Saleh on 13/12/2023.
//

import UIKit

class patientBookingTableViewController: UITableViewController {
    var patientUsing : Patient?
    var loggedInUsername = AppData.getLoggedInUsername()
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    func categorizeBookings() {
        listOfBookings = AppData.bookings
        upcomingBookings = listOfBookings.filter { $0.patient.username == loggedInUsername && $0.status == .upcoming }
        completedBookings = listOfBookings.filter { $0.patient.username == loggedInUsername && $0.status == .completed }
        cancelledBookings = listOfBookings.filter { $0.patient.username == loggedInUsername && $0.status == .cancelled }
    }

    
    //declare
    var listOfBookings = AppData.bookings
    var upcomingBookings : [booking] = []
    var completedBookings : [booking] = []
    var cancelledBookings : [booking] = []
    var selectedSegement = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       categorizeBookings()
        
    }

    @IBAction func segmentedControlChanged(_ sender: Any) {
        selectedSegement = segmentedControl.selectedSegmentIndex
        categorizeBookings()
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    var bookings = AppData.sampleBookings
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch selectedSegement {
               case 0: return upcomingBookings.count
               case 1: return completedBookings.count
               case 2: return cancelledBookings.count
               default: return bookings.count
               }
     
    }

 
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath) as! PatientHistoryTableViewCell
        
        let book: booking
        switch selectedSegement {
        case 0: book = upcomingBookings[indexPath.row]
        case 1: book = completedBookings[indexPath.row]
        case 2: book = cancelledBookings[indexPath.row]
        default: fatalError("Invalid segment")
        }

    //    let book = bookings[indexPath.row]
   
      
        
        guard let year = book.booking_date.year, let month = book.booking_date.month, let day = book.booking_date.day else {
            return cell
        }
        cell.Date.text = "\(day)-\(month)-\(year)"
        cell.testName.text = book.medicalService.name
        cell.labName.text = book.medicalService.facility.name
        if(book.status == .upcoming){
            cell.status.textColor = UIColor.orange
            cell.status.text = "Upcoming"
        } else if(book.status == .cancelled){
            cell.status.textColor = UIColor.red
            cell.status.text = "Cancelled"
        } else if(book.status == .completed){
            cell.status.textColor = UIColor.green
            cell.status.text = "Completed"
        }
      
        // Configure the cell...

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? viewBookingTableViewController, let selected = tableView.indexPathForSelectedRow {
                let selectedBooking: booking
                switch selectedSegement {
                case 0: selectedBooking = upcomingBookings[selected.row]
                case 1: selectedBooking = completedBookings[selected.row]
                case 2: selectedBooking = cancelledBookings[selected.row]
                default: return // Or handle invalid segment
                }
                destination.selectedTest = selectedBooking
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        categorizeBookings()
        tableView.reloadData()
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     
            if editingStyle == .delete {
                // Delete the row from the data source
                confirmation(title: "Confirm Deletion", message: "Do you want to delete this record? If it is active, it will lead to automatic cancellation") {
                    let bookingToRemove: booking
                    switch self.selectedSegement {
                    case 0: bookingToRemove = self.upcomingBookings[indexPath.row]
                            self.upcomingBookings.remove(at: indexPath.row)
                    case 1: bookingToRemove = self.completedBookings[indexPath.row]
                            self.completedBookings.remove(at: indexPath.row)
                    case 2: bookingToRemove = self.cancelledBookings[indexPath.row]
                            self.cancelledBookings.remove(at: indexPath.row)
                    default: return
                    }

                    if let index = AppData.bookings.firstIndex(where: { $0 == bookingToRemove }) {
                        AppData.bookings.remove(at: index)
                    }
                    
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.categorizeBookings() // Refresh the categorized bookings
                }
            }

        }
    
    
    @IBAction func logOutToMain(_ sender: Any) {
        Alerts.showLogoutConfirmation(on: self) {
            Utility.switchToStoryboard(named: "Main")
        }
    }
    

}
