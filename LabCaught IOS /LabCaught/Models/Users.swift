//
//  Users.swift
//  LabCaught
//
//  Created by mobileProg on 10/12/2023.
//

import Foundation


// Equatable to allow User instances to be compared, and Codable to enables easy serialization and deserialization.
class User: Equatable, Codable {

    // Properties common to all users.
    var username: String
    var password: String
    var createdOn: Date // Date when the user account was created.
    var phoneNumber: Int //// User's phone number.
    
    // Equatable protocol conformance - provides a way to compare two User instances.
    // Users are considered equal if they have the same username.
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.username == rhs.username
    }

     
    // Sets up a new user with provided username, password, and phone number.
    
    init(username: String, password: String, createdOn: Date = Date(), phoneNumber: Int) {
        self.username = username
        self.password = password
        self.createdOn = createdOn // The createdOn date is automatically set to the current date but can be overridden.
        self.phoneNumber = phoneNumber
    }
}


