//
//  Constants.swift
//  Gas
//
//  Created by Strong on 4/1/21.
//

import UIKit

enum LayoutGuidance {
    static let offset: CGFloat = 16
    static let offsetHalf: CGFloat = 8
    static let offsetDouble: CGFloat = 32
    static let offsetQuarter: CGFloat = 4
    static let offsetAndHalf: CGFloat = 20
    static let cornerRadius: CGFloat = 12
}

enum FontSize {
    /// 24px
    static let bigSize: CGFloat = 24
    /// 16px
    static let regularSize: CGFloat = 16
    /// 14px
    static let smallSize: CGFloat = 14
}

enum ViewSize {
    static let buttonHeight: CGFloat = 52
}

enum RegexConstants {
    static let passwordRegex = "[a-zA-Z0-9.!@#$%^&*]"
    static let allowedSymbolsForDigitsRegex = "[0-9 ]"
    static let allowedSymbolsForNumberRegex = "[0-9]"
    static let allowedSymbolsForCyrillycRegex = "[а-яА-Я ӘҢҒҮҰҚӨҺәіңғүұқөһ -]"
    static let allowedSymbolsForVinCodeRegex = "[A-Za-z0-9]"
    static let allowedSymbolsForIbanRegex = "[A-Z0-9 ]"
    static let allowedSymbolsForDocumentNumberRegex = "[A-Z0-9]"
    static let allowedSymbolsForNameRegex = "[a-zA-Zа-яА-Я0-9 ,.()+:?'-/\n]"
    static let allowedSymbolsForCyrillycNameRegex = "[а-яА-Я ӘҢҒҮҰҚӨҺәіңғүұқөһ ,.()+:?'-/\n -]"
    static let allowedSymbolsForForeignRuNameRegex = "[a-zA-Zа-яА-Я0-9 ,.()+:?'-/]"
    static let allowedSymbolsForForeignNameRegex = "[a-zA-Z0-9 ,.()+:?'-/]"
    static let allowedSymbolsForLatinRegex = "[A-Za-z ]"
    static let nonCyrillicSymbolsSubstringsRegex = #"(([a-zA-Z]{1}[a-zA-Z0-9\/\-?:().,\'+\ ]+)|([a-zA-Z]{1}))+"#
}
