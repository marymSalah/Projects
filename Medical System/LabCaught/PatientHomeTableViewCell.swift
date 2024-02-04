//
//  PatientHomeTableViewCell.swift
//  LabCaught
//
//  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 19/12/2023.
//

import UIKit

class PatientHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var facilityLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var facilityLogo: UIImageView!
    
    
    
    func configure(item: SearchCell){
        let facility = item as! Facility
        nameLbl.text = facility.name
        facilityLbl.text = facility.location
        typeLbl.text = facility.facilityType.rawValue
        
        facility.fetchLogoImage { [weak self] image in
            DispatchQueue.main.async {
                self?.facilityLogo.image = image
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset image properties
        self.facilityLogo.image = nil
        // Apply any default layout or content settings
    }


}
protocol SearchCell {
    
}

extension Facility: SearchCell {
    
}
