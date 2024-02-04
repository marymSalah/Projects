//
//  Patient.swift
//  LabCaught
//
//  Created by mobileProg on 10/12/2023.
//

import Foundation

// The Patient class inherits from User and it has a specific properties and methods meant for a patient.
class Patient: User {
    
    // Properties specific to the Patient class.
    var firstName: String
    var lastName: String
    var DOB: DateComponents // Date of Birth represented as DateComponents.
    var CPR: Int // which is A unique identifier for the patient.

    
    // this init: initializes both Patient specifics and inherited User properties.
    init(username: String, password: String, phoneNumber: Int, firstName: String, lastName: String, DOB: DateComponents, CPR: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.CPR = CPR
        super.init(username: username, password: password, createdOn: Date(), phoneNumber: phoneNumber)
    }


    // Required initializer for decoding instances of Patient.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
       // Decoding each property using the keys defined in CodingKeys.
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        DOB = try container.decode(DateComponents.self, forKey: .DOB)
        CPR = try container.decode(Int.self, forKey: .CPR)
         // Calling the superclass initializer to decode the inherited properties.
        try super.init(from: try container.superDecoder())
    }

     // Method to encode instances of Patient.
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
       // Encoding each property using the keys defined in CodingKeys.
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(DOB, forKey: .DOB)
        try container.encode(CPR, forKey: .CPR)
        // Calling the superclass method to encode the inherited properties.
        try super.encode(to: container.superEncoder())
    }

     // Enumeration to define the coding keys used in encoding and decoding.
    private enum CodingKeys: String, CodingKey {
        case firstName, lastName, DOB, CPR
    }
}


