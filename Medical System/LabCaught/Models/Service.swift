//
//  Service.swift
//  LabCaught
//
//  Created by Sara Khalifa Ebrahim Khalifa Hamdan on 19/12/2023.
//

import Foundation
class Service: Codable {
    var name: String
    var cost: String
    var describtion: String
    var insrtuctions: String
    
    var facility: Facility!

    
    init(name: String, cost: String, describtion: String, insrtuctions: String, facility: Facility) {
        self.name = name
        self.cost = cost
        self.describtion = describtion
        self.insrtuctions = insrtuctions
        self.facility = facility
    }
}
