//
//  Test.swift
//  LabCaught
//
//  Created by Maryam Salah Hashem Adnan Saleh on 13/12/2023.
//

import Foundation
class Test: Service, Equatable {
    static func == (lhs: Test, rhs: Test) -> Bool {
        lhs.name == rhs.name
    }
    
   
    override init(name: String, cost: String, describtion: String, insrtuctions: String, facility: Facility) {
        super.init(name: name, cost: cost, describtion: describtion, insrtuctions: insrtuctions, facility: facility)
    }

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        let superEncoder = container.superEncoder()
        try super.encode(to: superEncoder)
    }
    
}
