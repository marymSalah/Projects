//
//  Admin.swift
//  LabCaught
//
//  Created by mobileProg on 10/12/2023.
//

import Foundation

class Admin: User {
    var department: String
    var firstName: String
    var lastName: String

    init(username: String, password: String,department: String, firstName: String, lastName: String, phoneNumber: Int) {
        // Initialize all properties of the subclass first.
        self.department = department
        self.firstName = firstName
        self.lastName = lastName
        
       
        super.init(username: username, password: password, createdOn: Date(), phoneNumber: phoneNumber)
   
    }


    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        department = try container.decode(String.self, forKey: .department)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(department, forKey: .department)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        let superEncoder = container.superEncoder()
        try super.encode(to: superEncoder)
    }

    private enum CodingKeys: String, CodingKey {
        case department, firstName, lastName
    }
}


