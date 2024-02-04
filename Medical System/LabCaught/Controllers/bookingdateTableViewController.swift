//
//  bookingdateTableViewController.swift
//  LabCaught
//
//  Created by Maryam Salah on 18/12/2023.
//

import UIKit

class bookableViewController: UITableViewController {
    @IBOutlet weak var db1: UIDatePicker!
    
    @IBOutlet weak var location: UILabel!
    //declare elements
    @IBOutlet weak var testCell: UITableViewCell!
    var test : Service?
    @IBOutlet weak var datePick: UIDatePicker!
    @IBOutlet weak var CostLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var testsInclueLabel: UILabel!
    @IBOutlet weak var DescribtionLabel: UILabel!
    @IBOutlet weak var InstructionLabel: UILabel!
    var service: Service?
    
    //nada added this
    init?(coder: NSCoder, service: Service?){
        self.service = service
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.service = nil
        super.init(coder: coder)
    }
    //end
    
    
    
    @IBAction func bookBtn(_ sender: Any) {
        //var selectedDate = datePick.date
        //let currentDate = Date()
        //if selectedDate >= currentDate {
       // confirmation(title: "", message: ""){
            
     //   }
        let alert = UIAlertController(title: "Confirm Booking", message: "Are you sure you want to proceed with the booking?", preferredStyle: .alert)
        
            let bookAction = UIAlertAction(title: "Book", style: .default) { _ in
                self.handleBookingConfirmed()
            }
            alert.addAction(bookAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        } //else {
           // let alert = UIAlertController(title: "Invalid", message: "Please select Valid Date", preferredStyle: .alert)
            
           // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           // alert.addAction(cancelAction)
          //  present(alert, animated: true, completion: nil)
       // }

        
    //}
    

    private func handleBookingConfirmed() {
        // Add your booking confirmation logic here
        var patientusing: Patient?
        guard let service = test else {
            return
        }
        let user1 = findLoggedInUser()
        print("booking added")
        let selectedDate = db1.date
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)

        patientusing = user1
        guard let user2 = patientusing else{
            return
        }
        let booking1 = booking(booking_date: dateComponents, patient: user2, medicalService: service)
        AppData.sampleBookings.append(booking1)
        AppData.bookings.append(booking1)
        print("booking added")
        AppData.saveToFile()
    }
    
    func findLoggedInUser() -> Patient? {
        // Retrieve the saved username
        guard let savedUsername = AppData.getLoggedInUsername() else {
            return nil
        }

        // Search in patients
        if let patient = AppData.patient.first(where: { $0.username == savedUsername }) {
            return patient
        }

        return nil
    }

    // Call this method when the user initiates the booking process
    



    var isEditingDate = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
            // Assuming you add a UILabel for the date, update its color and text here
            //dobLabel.textColor = isEditingDate ? .blue : .label // Change color as needed
            //dobLabel.text = formattedDate(date: datePicker.date)
        }
    }

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var dobLabel: UILabel! // Make sure to connect this IBOutlet in your storyboard

    override func viewDidLoad() {
        super.viewDidLoad()
        //datePick.date = Date()
        // datePick.date = Date()
        // Additional setup if needed
    updateView()
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 // One row for the trigger, one for the date picker
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePicker", for: indexPath)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cost", for: indexPath)
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "instruction", for: indexPath)
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "description", for: indexPath)
            return cell
        } else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "testInclude", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePicker2", for: indexPath)
            return cell
        }
        
    }
    */
    
    func updateView(){
        guard let test = test else {
            return
        }
        location.text = test.facility.location
        NameLabel.text = test.name
        CostLabel.text = test.cost + " BHD"
        InstructionLabel.text = test.insrtuctions
        DescribtionLabel.text = test.describtion
        if test is Test {
            testCell.isHidden = true
        }else if test is Packages {
            let package1 = test as! Packages
            var label = "Test includes:\n "
            for t in package1.packageIncludes {
                label += "-\(t.name)\n"
            }
            
            testsInclueLabel.text = label
        }
        
        
    }

  //  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      //  if indexPath.row == 1 && !isEditingDate {
        //    return 0 // Hide the date picker cell
      //  } else {
       //     return UITableView.automaticDimension
       // }
  //  }

   // override func tableView(_ tableView: UITableView, didSelectRowAt //indexPath: IndexPath) {
     //   if indexPath.row == 0 {
       //     isEditingDate.toggle() // Toggle visibility of date picker
       //     tableView.deselectRow(at: indexPath, animated: true)
       // }
   // }

    // Action for date picker value changed
  //  @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
  //      dobLabel.text = formattedDate(date: sender.date)
  //  }

    // Format the date to a string
   // private func formattedDate(date: Date) -> String {
     //   let formatter = DateFormatter()
    //    formatter.dateStyle = .medium
    //    return formatter.string(from: date)
//    }

    // Modify the saveButtonTapped method
    //@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
      //  let selectedDate = datePicker.date
        // Use selectedDate to create new Employee object
        // ...
    //}
}
