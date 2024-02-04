//
//  Admin.swift
//  LabCaught
//
//  Created by mobileProg on 10/12/2023.
//

import Foundation

// The Admin class inherits from User and adds additional properties and methods specific to an administrator user.
class Admin: User {
    // Properties that are specific to the Admin class.
    var department: String // The department the admin belongs to.
    var firstName: String
    var lastName: String

         
    //init: to Initializes both Admin specifics and inherited User properties.
    init(username: String, password: String,department: String, firstName: String, lastName: String, phoneNumber: Int) {
        // Initialize all properties of the subclass first.
        self.department = department
        self.firstName = firstName
        self.lastName = lastName
        
       // Calling to the superclass initializer to set up inherited properties.
        super.init(username: username, password: password, createdOn: Date(), phoneNumber: phoneNumber)
   
    }

     // Required initializer for decoding instances of the Admin user.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decoding each property using the keys defined in CodingKeys.
        department = try container.decode(String.self, forKey: .department)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
         // Calling the superclass initializer to decode inherited properties.
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }

     // Method to encode instances of Admin.
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // Encode each property using the keys defined in CodingKeys.
        try container.encode(department, forKey: .department)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        // Calling the superclass method to encode inherited properties.
        let superEncoder = container.superEncoder()
        try super.encode(to: superEncoder)
    }

    // Enumeration to define the coding keys used in encoding and decoding.
    private enum CodingKeys: String, CodingKey {
        case department, firstName, lastName
    }
}


