//
//  LabBookingsTableViewCell.swift
//  LabCaught
//
//  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 26/12/2023.
//

import UIKit

class LabBookingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CPRLbl: UILabel!
    @IBOutlet weak var testNameLbl: UILabel!
    @IBOutlet weak var bookingDateLbl: UILabel!
    
    func configure(booking: booking){
        CPRLbl.text = "\(booking.patient.CPR)"
        testNameLbl.text = booking.medicalService.name
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let dateString = dateFormatter.string(from: booking.booking_date)
//        bookingDateLbl.text = dateString
        
        
        let calendar = Calendar.current
        let date = calendar.date(from: booking.booking_date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: date!)
        bookingDateLbl.text = dateString
        
    }
}
