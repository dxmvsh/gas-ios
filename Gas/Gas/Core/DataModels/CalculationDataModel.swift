//
//  CalculationDataModel.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import Foundation

struct CalculationRequestDataModel: Codable {
    var current_indicators: Decimal?
    var last_indicators: Decimal?
    var account_number: String?
}

struct CalculationDataModel: Codable {
    var tariff: Decimal
    var used: Decimal
    var amount: Decimal
}
