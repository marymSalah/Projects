//
//  AppData.swift
//  LabCaught
//
//  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 19/12/2023.
//



import Foundation

// This class acts as a central data store for the app.
class AppData {
    // Array to store registered users.
    static var users: [User] = []
    // Array to store registered patients.
    static var patient: [Patient] = []
    // Array to store facility information.
   static var facilites = [Facility]()
   // Array to store booking information.
   static var bookings: [booking] = []
   // Array to store service information.
   static var services = [Service]()
    

    // Saving the logged-in username to UserDefaults.
        static func saveLoggedInUsername(username: String) {
            UserDefaults.standard.set(username, forKey: "LoggedInUsername")
        }

        // Retrieving the logged-in username from UserDefaults.
        static func getLoggedInUsername() -> String? {
            return UserDefaults.standard.string(forKey: "LoggedInUsername")
        }
    
    
    // Method to check if a username is already in use.
    static func isUsernameInUse(username: String) -> Bool {
        return users.contains { $0.username.lowercased() == username.lowercased() } ||
        admins.contains { $0.username.lowercased() == username.lowercased() }
    }
    
    // ... other static methods or properties ...
    
    //don't touch this (this is for saving registerd user information
     // Function to add a new user to the patient array and save it.
    static func addUser(username: String, password: String, phoneNumber: Int, firstName: String, lastName: String, dob: DateComponents, cpr: Int) {
        let newUser = Patient(username: username, password: password, phoneNumber: phoneNumber, firstName: firstName, lastName: lastName, DOB: dob, CPR: cpr)
        patient.append(newUser)
        //nada
        users.append(newUser)
        saveToFile()
    }

    
    // Edit an existing user's information.
    static func editUser(user: User) {
        if let index = users.firstIndex(where: { $0.username == user.username }) {
            users.remove(at: index)
            users.insert(user, at: index)
            saveToFile()
        }
    }

    // Delete a user from the array.
    static func deleteUser(user: User) -> Bool {
        if let index = users.firstIndex(where: { $0.username == user.username }) {
            users.remove(at: index)
            saveToFile()
            return true
        }
        return false
    }
    
    
    // Call this method when you want to initialize your app data.
    // Initialize app data, primarily by loading from UserDefaults.
    static func initializeAppData() {
        // Load user data from UserDefaults.
        //loadFromFile()
        // Load other initial settings as needed.
    }
    
    //nada's methods
    // maybe i should take this function to the appData page
    static func getServices(facility: Facility) -> [Service]{
        return services.filter { $0.facility.username == facility.username}
    }
    
    static func editBookingStatus(booking: booking, status: statusType){
        if let index = bookings.firstIndex(of: booking) {
            bookings[index].status = status
            saveToFile()
        }
    }
    
}

// Extension to manage facility-related functionalities.
extension AppData {
    // Retrieve a facility by username.
    static func getFacility(username: String) -> Facility? {
        facilites.first(where: { $0.username == username })
    }

    // Add a new facility to the array.
    static func addFacility(facility: Facility) {
        facilites.append(facility)
        saveToFile()
    }
    // Edit an existing facility's information.
    static func editFacility(facility: Facility) {
        if let index = facilites.firstIndex(of: facility) {
            facilites.remove(at: index)
            facilites.insert(facility, at: index)
            saveToFile()
        }
    }

    // Delete a facility from the array.
    static func deleteFacility(facility: Facility) {
        let index = AppData.facilites.firstIndex(of: facility) ?? 0
        if let _ = AppData.facilites.first(where: { $0.facilityType == .hospital }){
            
        }
        if let _ = AppData.facilites.first(where: { $0.facilityType == .lab }){
            
        }
        AppData.facilites.remove(at: index)
        saveToFile()
        
    }
}
