import Foundation
import FirebaseStorage
import UIKit

// Enum to specify the type of facility (hospital or lab).
enum FacilityType: String, Codable, Equatable{
    case hospital
    case lab
    
     // Computed property to provide a string representation for each facility type.
    var description: String{
        switch self{
            case.hospital:
                return "Hospital"
            case.lab:
                return "Lab"
        }
    }
}

// Facility class inherits from User and adds specific properties and methods that are desigend for a facility.
class Facility: User{
    
    // Properties that are specific to the Facility class.
    var name: String
    var location: String
    var isOpen24Hours: Bool
    var openingTime: DateComponents
    var closingTime: DateComponents
    var facilityType: FacilityType
    var logoImageName: String // Name of the image file or URL as a string
    


    func fetchLogoImage(completion: @escaping (UIImage?) -> Void) {
            let storageRef = Storage.storage().reference().child("images/\(logoImageName)")
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error downloading image: \(error)")
                        completion(nil)
                    } else if let data = data {
                        completion(UIImage(data: data))
                    }
                }
            }
        }
   
    // It initializes both Facility-specific and inherited User properties.
    init(username: String, password: String, phoneNumber: Int, name: String, location: String, isOpen24Hours: Bool, openingTime: DateComponents, closingTime: DateComponents, facilityType: FacilityType, logoImageName: String) {
        self.name = name
        self.location = location
        self.isOpen24Hours = isOpen24Hours
        self.openingTime = openingTime
        self.closingTime = closingTime
        self.facilityType = facilityType
        self.logoImageName = logoImageName

        super.init(username: username, password: password, createdOn: Date(),  phoneNumber: phoneNumber)
    }
    
    // Required initializer for decoding instances of Facility.
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
            // Decoding each property using the keys defined in CodingKeys.
            name = try container.decode(String.self, forKey: .name)
            location = try container.decode(String.self, forKey: .location)
            isOpen24Hours = try container.decode(Bool.self, forKey: .isOpen24Hours)
            openingTime = try container.decode(DateComponents.self, forKey: .openingTime)
            closingTime = try container.decode(DateComponents.self, forKey: .closingTime)
            facilityType = try container.decode(FacilityType.self, forKey: .facilityType)
            logoImageName = try container.decode(String.self, forKey: .logoImageName)
           // Calling the superclass initializer to decode inherited properties.
        try super.init(from: decoder)
    }

    // Method to encode instances of Facility.
    override func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
            // Encoding each property using the keys defined in CodingKeys.
        try container.encode(name, forKey: .name)
            try container.encode(location, forKey: .location)
            try container.encode(isOpen24Hours, forKey: .isOpen24Hours)
            try container.encode(openingTime, forKey: .openingTime)
            try container.encode(closingTime, forKey: .closingTime)
            try container.encode(facilityType, forKey: .facilityType)
            try container.encode(logoImageName, forKey: .logoImageName)
            // Calling the superclass method to encode inherited properties.
        try super.encode(to: encoder)
    }

    // Enumeration to define the coding keys used in encoding and decoding.
    private enum CodingKeys: String, CodingKey{
            case name, location, isOpen24Hours, openingTime, closingTime, facilityType, logoImageName
    }
}
