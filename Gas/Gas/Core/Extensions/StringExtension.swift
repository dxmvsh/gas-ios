//
//  StringExtension.swift
//  Gas
//
//  Created by Strong on 4/4/21.
//

import UIKit

extension String {
    var whitespaceless: Self {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var onlyDigits: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }
    
    func substr(_ lower: Int, _ upper: Int? = nil) -> String {
        // guard against negative lower bound
        var low = max(0, lower)
        // guard against lower bound overflown
        low = min(count, low)
        // guard against nil or overflown upper bound
        var up = min(count, upper ?? count)
        // guard against upper < lower case
        up = max(up, low)

        return self[Range(uncheckedBounds: (low, up))]
    }

    subscript (range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[Range(uncheckedBounds: (lower: start, upper: end))])
    }
    
    func toDate(format: DateFormat, locale: String = "ru") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self) ?? Date()
    }
}
