//
//  Converter.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation

class Converter {
    static func makeApiErrorCode(string: String) -> ApiError.Code {
        for code in ApiError.Code.allCases {
            if code.rawValue == string {
                return code
            }
        }
        return .noCode
    }
}
