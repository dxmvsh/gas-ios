//
//  PasswordViewModel.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import Foundation

class PasswordViewModel: PasswordViewOutput, PasswordModuleInput {
    
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
    
    private var userDataModel: UserDataModel?
    
    private let dataProvider: AuthorizationServiceProtocol
    
    init(passwordChecker: PasswordCheckerService,
         dataProvider: AuthorizationService) {
        self.passwordChecker = passwordChecker
        self.dataProvider = dataProvider
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
        if password != confirmPassword {
            view?.showConfirmPasswordError("Пароли не совпадают")
            return
        }
        
        if var userDataModel = userDataModel {
            userDataModel.password = password
            dataProvider.register(user: userDataModel) { [weak self] result in
                switch result {
                case .success(let message):
                    if message.message == .success {
                        self?.output?.didSucceedPasswordSet()
                    } else {
                        self?.output?.didFailPasswordSet()
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
    
    private func updateButtonAvailability() {
        view?.setButton(active: arePasswordsValid)
    }
    
    func configure(userDataModel: UserDataModel) {
        self.userDataModel = userDataModel
    }
}

extension PasswordViewModel: PasswordCheckerServiceOutput {
    
    func didCheck(isValid: [Bool]) {
        view?.setRulesHighlighted(isValid)
    }
    
}
