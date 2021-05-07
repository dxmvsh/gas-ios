//
//  PasswordCheckerService.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import Foundation

protocol PasswordCheckerService {
    var isValid: Bool { get }
    func setRegexRules(_ rules: [String])
    func setPassword(_ password: String)
}

protocol PasswordCheckerServiceOutput: class {
    func didCheck(isValid: [Bool])
}

class PasswordChecker: PasswordCheckerService {
    
    private var regexRules: [String] = []
    
    weak var output: PasswordCheckerServiceOutput?
    var isValid = false
    
    func setRegexRules(_ rules: [String]) {
        regexRules = rules
    }
    
    func setPassword(_ password: String) {
        checkPassword(password)
    }
    
    private func checkPassword(_ password: String) {
        let range = NSRange(location: .zero, length: password.count)
        var highlighted: [Bool] = []
        for regexString in regexRules {
            if let regex = try? NSRegularExpression(pattern: regexString) {
                let matchesRegex = regex.firstMatch(in: password, options: [], range: range) != nil
                highlighted.append(matchesRegex)
            }
        }
        isValid = !highlighted.contains(false)
        output?.didCheck(isValid: highlighted)
    }
}
