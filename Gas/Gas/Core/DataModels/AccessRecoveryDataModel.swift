//
//  AccessRecoveryDataModel.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import Foundation

struct AccessRecoveryDataModel: Codable {
    var email: String
    var new_password: String?
    var confirm_password: String?
}
