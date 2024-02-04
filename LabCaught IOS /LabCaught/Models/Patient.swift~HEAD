//
//  Patient.swift
//  LabCaught
//
//  Created by mobileProg on 10/12/2023.
//

import Foundation

class Patient: User {
    var firstName: String
    var lastName: String
    var DOB: DateComponents
    var CPR: Int
    
    init(username: String, password: String, phoneNumber: Int, firstName: String, lastName: String, DOB: DateComponents, CPR: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.CPR = CPR
        super.init(username: username, password: password, createdOn: Date(), phoneNumber: phoneNumber)
    }


    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        DOB = try container.decode(DateComponents.self, forKey: .DOB)
        CPR = try container.decode(Int.self, forKey: .CPR)
        try super.init(from: try container.superDecoder())
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(DOB, forKey: .DOB)
        try container.encode(CPR, forKey: .CPR)
        try super.encode(to: container.superEncoder())
    }
    
    private enum CodingKeys: String, CodingKey {
        case firstName, lastName, DOB, CPR
    }
}


