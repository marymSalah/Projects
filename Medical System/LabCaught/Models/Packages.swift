//
//  packages.swift
//  LabCaught
//
//  Created by Maryam Salah Hashem Adnan Saleh on 13/12/2023.
//

import Foundation
class Packages : Service {
    
    var packageIncludes: [Test]
    var packageExpiry: DateComponents
    //var isLab: Bool
    //var tests: [test]
    
    
    init(name: String, cost: String, describtion: String, insrtuctions: String, packageIncludes: [Test], packageExpiry: DateComponents, facility: Facility) {
        self.packageIncludes = packageIncludes
        self.packageExpiry = packageExpiry
        
        super.init(name: name, cost: cost, describtion: describtion, insrtuctions: insrtuctions, facility: facility)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        packageIncludes = try container.decode([Test].self, forKey: .packageIncludes)
        packageExpiry = try container.decode(DateComponents.self, forKey: .packageExpiry)
        try super.init(from: container.superDecoder())
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(packageIncludes, forKey: .packageIncludes)
        try container.encode(packageExpiry, forKey: .packageExpiry)
        try super.encode(to: container.superEncoder())
    }

    private enum CodingKeys: String, CodingKey {
        case packageIncludes, packageExpiry
    }
    
}
