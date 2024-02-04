//
//  HospitalLabTableViewCell.swift
//  LabCaught
//
//  Created by Shaikha Hasan Ali Hasan Ali Mohamed on 20/12/2023.
//

import UIKit
import FirebaseStorage

class HospitalLabTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var facilityNameLabel: UILabel!
    @IBOutlet weak var FacilityLocationLabel: UILabel!
    @IBOutlet weak var FacilityTypeLabel: UILabel!
    @IBOutlet weak var FacilityLogo: UIImageView!
    
    
    func configure (faclity: Facility) {
        facilityNameLabel.text = faclity.name
        FacilityLocationLabel.text = faclity.location
        FacilityTypeLabel.text = faclity.facilityType.rawValue
        
        faclity.fetchLogoImage { [weak self] image in
                    self?.FacilityLogo.image = image
                }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
