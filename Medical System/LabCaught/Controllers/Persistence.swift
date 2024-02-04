////
////  Persistence.swift
////  LabCaught
////
////  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 04/01/2024.
////
//
//import Foundation
//
//

import Foundation
extension AppData {
    
     enum FileName: String {
        case patients, facilities, bookings, tests, package
    }
    
    
    fileprivate static func archiveURL(fileName: FileName) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent(fileName.rawValue).appendingPathExtension("plist")
    }
    
    static func load(){
        loadUsers(fileName: .facilities)
        loadUsers(fileName: .patients)
        loadServices(fileName: .tests)
        loadServices(fileName: .package)
        loadBookings()
        
        if bookings.isEmpty {
            bookings = sampleBookings
        }
        if facilites.isEmpty {
            facilites = sampleFacilities
        }
        if services.isEmpty {
            services = allTestsPackages
        }
        if patient.isEmpty{
            patient = samplePatients
        }
    }
    
    static func saveToFile(){
        saveUsers(fileName: .facilities)
        saveUsers(fileName: .patients)
        saveServices(fileName: .tests)
        saveServices(fileName: .package)
        saveBookings()
    }
    
      static func saveUsers(fileName: FileName) {
        let encoder = PropertyListEncoder()
        do {
            if fileName == .patients {
                let patients : [Patient] = patient
                if !patients.isEmpty {
                    let encodedPatients = try encoder.encode(patients)
                    try encodedPatients.write(to: archiveURL(fileName: .patients))
                }
            } else {
                let facilites: [Facility] = facilites
                if !facilites.isEmpty {
                    let encodedFacilites = try encoder.encode(facilites)
                    try encodedFacilites.write(to: archiveURL(fileName: .facilities))
                }
            }
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
      static func loadUsers(fileName: FileName) {
        let url = archiveURL(fileName: fileName)
        guard let data = try? Data(contentsOf: url) else { return }
        do {
            let decoder = PropertyListDecoder()
            var decodedPatient : [Patient] = []
            var decodedFacility : [Facility] = []
            if fileName == .patients {
                decodedPatient = try decoder.decode([Patient].self, from: data)
                patient.append(contentsOf: decodedPatient)
            } else {
                decodedFacility = try decoder.decode([Facility].self, from: data)
                facilites.append(contentsOf: decodedFacility)
            }
        } catch {
            print("Error decoding data: \(error)")
        }
    }
    
      static func saveServices(fileName: FileName) {
        let encoder = PropertyListEncoder()
        do {
            if fileName == .tests {
                let tests : [Test] = services.compactMap{ $0 as? Test }
                if !tests.isEmpty {
                    let encodedTests = try encoder.encode(tests)
                    try encodedTests.write(to: archiveURL(fileName: .tests))
                }
            } else {
                let packages: [Packages] = services.compactMap { $0 as? Packages }
                if !packages.isEmpty {
                    let encodedPackages = try encoder.encode(packages)
                    try encodedPackages.write(to: archiveURL(fileName: .package))
                }
            }
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
      static func loadServices(fileName: FileName) {
        let url = archiveURL(fileName: fileName)
        guard let data = try? Data(contentsOf: url) else { return }
        do {
            let decoder = PropertyListDecoder()
            var decodedServices : [Service] = []
            if fileName == .tests {
                decodedServices = try decoder.decode([Test].self, from: data)
            } else {
                decodedServices = try decoder.decode([Packages].self, from: data)
            }
            services.append(contentsOf: decodedServices)
        } catch {
            print("Error decoding data: \(error)")
        }
        
    }
    
    static func saveBookings() {
        guard bookings.count > 0 else { return}
        let encoder = PropertyListEncoder()
        do {
            let encodedBookings = try encoder.encode(bookings)
            try encodedBookings.write(to: archiveURL(fileName: .bookings))
        }
        catch {
            print("Error encoding data: \(error)")
        }
    }
    
    static func loadBookings() {
        let url = archiveURL(fileName: .bookings)
        guard let data = try? Data(contentsOf: url) else { return }
        do {
            let decoder = PropertyListDecoder()
            var decodedBookings : [booking] = []
            decodedBookings = try decoder.decode([booking].self, from: data)
            bookings.append(contentsOf: decodedBookings)
        }catch {
            print("Error decoding data: \(error)")
        }
    }
     
}

