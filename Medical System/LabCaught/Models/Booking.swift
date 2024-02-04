//
//  booking.swift
//  LabCaught
//
//  Created by Maryam Salah Hashem Adnan Saleh on 13/12/2023.
//
enum statusType : String,Codable{
    case
    upcoming = "Upcoming",
    completed = "completed",
    cancelled = "cancelled"
}
import Foundation
//it should be there
class booking: Equatable, Codable{
    static func == (lhs: booking, rhs: booking) -> Bool {
        lhs.patient == rhs.patient && lhs.booking_date == rhs.booking_date
    }
    var serviceType: String
    var booking_date:DateComponents
    var patient:Patient
    var status: statusType
    //var isPackage:Bool
    var medicalService: Service
    init(booking_date: DateComponents, patient: Patient, medicalService: Service) {
        self.booking_date = booking_date
        self.patient = patient
        self.medicalService = medicalService
        status = .upcoming
        self.serviceType = medicalService is Test ? "Test" : "Packages"
    }
    
    enum CodingKeys: CodingKey, Codable {
        case patient,medicalService,booking_date,status, serviceType
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patient, forKey: .patient)
        try container.encode(serviceType, forKey: .serviceType)
        if (medicalService is Test) {
            try container.encode(medicalService as! Test, forKey: .medicalService)
        } else if (medicalService is Packages) {
            try container.encode(medicalService as! Packages, forKey: .medicalService)
        }
        try container.encode(booking_date, forKey: .booking_date)
        try container.encode(status, forKey: .status)
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.patient = try values.decode(Patient.self, forKey: .patient)
        self.serviceType = try values.decode(String.self, forKey: .serviceType)
        // decode service based on type
        switch (serviceType) {
        case "Test":
            self.medicalService = try values.decode(Test.self, forKey: .medicalService)
            break
        case "Packages":
            self.medicalService = try values.decode(Packages.self, forKey: .medicalService)
            break
        default:
            fatalError("Could not load service for booking")
            break
        }
        self.booking_date = try values.decode(DateComponents.self, forKey: .booking_date)
        self.status = try values.decode(statusType.self, forKey: .status)
    }


    
    }
