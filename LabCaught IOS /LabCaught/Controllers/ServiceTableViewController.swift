//
//  ServiceTableViewController.swift
//  LabCaught
//
//  Created by Sara Khalifa Ebrahim Khalifa Hamdan on 20/12/2023.
//

import UIKit

class ServiceTableViewController: UITableViewController {


    var services = AppData.services.filter{$0.facility.username == AppData.getLoggedInUsername()}
    var displayedServices: [Service] = []
    var lastSelectedSegmentIndex: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplayedServices(segment: .tests)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            if let selectedSegment = ServiceSegment(rawValue: lastSelectedSegmentIndex) {
                updateDisplayedServices(segment: selectedSegment)
            }
            tableView.reloadData()
    }
    
    // An enum to differentiate between segments
    enum ServiceSegment: Int {
        case tests = 0
        case packages = 1
    }

    // Function to update the displayed services
    func updateDisplayedServices(segment: ServiceSegment) {
        switch segment {
        case .tests:
            displayedServices = AppData.services.filter {$0.facility.username == AppData.getLoggedInUsername() && $0 is Test }
        case .packages:
            displayedServices = AppData.services.filter {$0.facility.username == AppData.getLoggedInUsername() && $0 is Packages }
        }
        
        tableView.reloadData() // Reload the table view with the filtered data
    }

        
    
    
    @IBAction func updateDisplayedServices(_ sender: UISegmentedControl) {
            lastSelectedSegmentIndex = sender.selectedSegmentIndex
            guard let selectedSegment = ServiceSegment(rawValue: sender.selectedSegmentIndex) else { return }
            updateDisplayedServices(segment: selectedSegment)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedServices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! ServiceTableViewCell
        
        let service = displayedServices[indexPath.row]
        cell.configure(service: service)
        
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Present confirmation alert
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
                // Identify the service to delete
                let serviceToDelete = self.displayedServices[indexPath.row]

                // Remove the service from the displayed services
                self.displayedServices.remove(at: indexPath.row)
                
                // Also remove the service from the global AppData.services
                if let indexInGlobal = AppData.services.firstIndex(where: { $0 === serviceToDelete }) {
                    AppData.services.remove(at: indexInGlobal)
                }

                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)

                // Update persistent storage if necessary
                // AppData.saveServicesToFile()
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            alert.addAction(deleteAction)
            alert.addAction(cancelAction)

            // Present the alert
            self.present(alert, animated: true)
            
            AppData.saveToFile()
        }
    }


    
    func performDeletion(at indexPath: IndexPath) {
             // Delete the facility from the data source
                 AppData.sampleFacilities.remove(at: indexPath.row)
                 //updateDisplayedFacilities()
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue",
           let destinationVC = segue.destination as? ServiceFormTableViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedService = displayedServices[indexPath.row]
            destinationVC.service = selectedService
        }
    }
    
    @IBAction func logOutToMainScreen(_ sender: Any) {
        Alerts.showLogoutConfirmation(on: self) {
            Utility.switchToStoryboard(named: "Main")
        }
    }
}
