//
//  PaymentHistoryItemDataModel.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Foundation


struct PaymentHistoryItemDataModel: Codable {
    var id: Int
    var created_at: String
    var account_number: String
    var volume: Decimal
    var principal: Decimal
}
