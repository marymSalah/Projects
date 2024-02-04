//
//  ServiceTableViewCell.swift
//  LabCaught
//
//  Created by Sara Khalifa Ebrahim Khalifa Hamdan on 19/12/2023.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var costLbl: UILabel!
    
    func Configure(service: Service) {
        nameLbl.text = service.name
        costLbl.text = service.cost + "BD"
    }
    
}
