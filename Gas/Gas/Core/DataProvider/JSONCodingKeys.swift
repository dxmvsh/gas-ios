//
//  JSONCodingKeys.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation

struct JSONCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?

    init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }

    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
