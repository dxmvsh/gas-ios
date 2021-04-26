//
//  PasswordViewModel.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import Foundation

class PasswordViewModel: PasswordViewOutput {
    
    weak var view: PasswordViewInput?
    var output: PasswordModuleOutput?
    
    private var arePasswordsValid: Bool {
        return passwordChecker.isValid && password == confirmPassword
    }
    
    private let rules: [PasswordRuleViewAdapter] = [
        PasswordRuleViewAdapter(title: Text.atLeast8Chars, regex: RegexConstants.atLeast8Chars),
        PasswordRuleViewAdapter(title: Text.atLeast1UppercaseLetter, regex: RegexConstants.containsUppercaseLetter),
        PasswordRuleViewAdapter(title: Text.atLeast1LowercaseLetter, regex: RegexConstants.containsLowercaseLetter),
        PasswordRuleViewAdapter(title: Text.atLeast1Digit, regex: RegexConstants.allowedSymbolsForNumberRegex),
        PasswordRuleViewAdapter(title: Text.atLeastOneOfNextChars, regex: RegexConstants.containsPasswordParticularCharacter),
    ]
    
    private let passwordChecker: PasswordCheckerService
    
    private var password: String = ""
    private var confirmPassword: String = ""
    
    init(passwordChecker: PasswordCheckerService) {
        self.passwordChecker = passwordChecker
        passwordChecker.setRegexRules(rules.compactMap{ $0.regex })
    }
    
    func didLoad() {
        view?.setPasswordRules(rules)
    }
    
    func didChangePassword(_ password: String) {
        passwordChecker.setPassword(password)
    }
    
    func didSetPassword(_ password: String) {
        passwordChecker.setPassword(password)
        self.password = password
        updateButtonAvailability()
    }
    
    func didSetConfirmPassword(_ password: String) {
        self.confirmPassword = password
        updateButtonAvailability()
    }
    
    func didTapContinue() {
        view?.showConfirmPasswordError("Пароли не совпадают")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
        }
    }
    
    private func updateButtonAvailability() {
        view?.setButton(active: arePasswordsValid)
    }
}

extension PasswordViewModel: PasswordCheckerServiceOutput {
    
    func didCheck(isValid: [Bool]) {
        view?.setRulesHighlighted(isValid)
    }
    
}
