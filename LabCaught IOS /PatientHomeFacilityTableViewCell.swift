//
//  PatientHomeFacilityTableViewCell.swift
//  LabCaught
//
//  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 21/12/2023.
//

import UIKit


// This class represents a cell for displaying information about a patient's home facility service.
class PatientHomeFacilityTableViewCell: UITableViewCell {
    
    
    // Outlets to the UI elements in the cell.
    @IBOutlet weak var nameLbl: UILabel!  // Label for displaying the name of the service
    @IBOutlet weak var facilityLbl: UILabel!    // Label for displaying the name of the facility providing the service
    @IBOutlet weak var priceLbl: UILabel!   // Label for displaying the price of the service

    
    // This function configures the cell with data from a `Service` object.
    func configure(service: Service){
        // Setting the name label to the name of the service.
        nameLbl.text = service.name
        // Setting the facility label to the name of the facility providing the service.
        facilityLbl.text = service.facility.name
        // Setting the price label to the cost of the service.
        priceLbl.text = service.cost + " BHD"
    }

}
