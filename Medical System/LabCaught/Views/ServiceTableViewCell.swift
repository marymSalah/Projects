//
//  ServiceTableViewCell.swift
//  LabCaught
//
//  Created by Sara Khalifa Ebrahim Khalifa Hamdan on 20/12/2023.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    
    func configure(service: Service) {
        nameLbl.text = service.name
        costLbl.text = "\(service.cost) BHD"
    }

}
