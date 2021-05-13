//
//  PaymentHistoryCellAdapter.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Foundation

struct PaymentHistoryCellAdapter {
    var date: String
    var accountNumber: String
    var consumption: String
    var price: String
    
    init(data: PaymentHistoryItemDataModel) {
        self.date = data.created_at.toDate(format: .formatted_ISO8601).toString(format: .formatted_ddMMMMyyyyhh)
        self.accountNumber = data.account_number
        self.consumption = "\(data.volume) \(UnitVolume.cubicMeters.symbol)"
        self.price = "\(data.principal) ₸"
    }
}
