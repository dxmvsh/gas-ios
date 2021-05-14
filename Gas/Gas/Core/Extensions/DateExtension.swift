//
//  DateExtension.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Foundation

enum DateFormat: String {
    case formatted_ddMMMhh = "dd MMM HH:mm"
    case formatted_ddMMMMhh = "dd MMMM HH:mm"
    case formatted_ddMMMMyyyyhh = "dd MMMM yyyy, HH:mm"
    case formatted_ddMMMyyyy = "d MMM yyyy"
    case formatted_MMyyyy = "MM.yyyy"
    case formatted_yyyyMMdd = "yyyy-MM-dd"
    case formatted_ISO8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
    case formatted_yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case formatted_ddMMyy = "dd.MM.yy"
    case formatted_ddMMyyyy_dot = "dd.MM.yyyy"
    case formatted_MMMMyyyy = "MMMM yyyy"
    case formatted_MMMM = "MMMM"
    case formatted_MM = "MM"
    case formatted_ddMMM = "dd MMMM"

    var value: String {
        return self.rawValue
    }
}


extension Date {
    func toString(format: DateFormat,
                  locale: String = "ru",
                  timeZone: TimeZone? = TimeZone(abbreviation: "UTC")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func adjust(_ component: Calendar.Component, offset: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.setValue(offset, for: component)
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
}
