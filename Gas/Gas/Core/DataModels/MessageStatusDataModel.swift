//
//  MessageStatusDataModel.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation

struct MessageStatusDataModel: Codable {
    var message: MessageStatus
}

struct MessageWrapped: Codable {
    var message: String
}

enum MessageStatus: String, Codable {
    case success = "success"
    case fail = "fail"
}
