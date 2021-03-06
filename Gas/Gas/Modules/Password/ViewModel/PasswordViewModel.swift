//
//  PasswordViewModel.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import Foundation

enum PasswordMode {
    case set
    case recover
    case change
}

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
    
    private var oldPassword: String = ""
    private var password: String = ""
    private var confirmPassword: String = ""
    
    private var userDataModel: UserDataModel?
    private var accessRecoveryDataModel: AccessRecoveryDataModel?
    
    private let mode: PasswordMode
    private let dataProvider: AuthorizationServiceProtocol
    private let secureAuthService: SecureAuthenticationProtocol
    
    init(mode: PasswordMode,
         passwordChecker: PasswordCheckerService,
         dataProvider: AuthorizationService,
         secureAuthService: SecureAuthenticationProtocol) {
        self.mode = mode
        self.passwordChecker = passwordChecker
        self.dataProvider = dataProvider
        self.secureAuthService = secureAuthService
        passwordChecker.setRegexRules(rules.compactMap{ $0.regex })
    }
    
    func didLoad() {
        view?.setPasswordRules(rules)
        if mode == .change {
            view?.setOldPassword(isHidden: false)
        }
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
    
    func didSetOldPassword(_ password: String) {
        self.oldPassword = password
    }
    
    func didTapContinue() {
        if password != confirmPassword {
            view?.showConfirmPasswordError("???????????? ???? ??????????????????")
            return
        }
        switch mode {
        case .set:
            if var userDataModel = userDataModel {
                userDataModel.password = password
                dataProvider.register(user: userDataModel) { [weak self] result in
                    switch result {
                    case .success:
                        self?.secureAuthService.setPassword(userDataModel.password)
                        self?.secureAuthService.setEmail(userDataModel.email)
                        self?.output?.didSucceedPasswordSet()
                    case .failure(let error):
                        print("error: \(error)")
                        self?.output?.didFailPasswordSet()
                    }
                }
            }
        case .recover:
            if var model = accessRecoveryDataModel {
                model.new_password = password
                model.confirm_password = confirmPassword
                dataProvider.resetPassword(model: model) { [weak self] result in
                    switch result {
                    case .success(let message):
                        if message.message == .success {
                            if let password = self?.password {
                                self?.secureAuthService.setEmail(model.email)
                                self?.secureAuthService.setPassword(password)
                            }
                            self?.output?.didSucceedPasswordSet()
                        } else {
                            print("message failed")
                            self?.output?.didFailPasswordSet()
                        }
                    case .failure(let error):
                        print("error: \(error)")
                        self?.output?.didFailPasswordSet()
                    }
                }
            }
        case .change:
            dataProvider.changePassword(oldPassword: oldPassword, newPassword: password, confirmedPassword: confirmPassword) { [weak self] result in
                switch result {
                case .success(let message):
                    if message.message == .success {
                        if let password = self?.password {
                            self?.secureAuthService.setPassword(password)
                        }
                        self?.output?.didSucceedPasswordSet()
                    } else {
                        print("message failed")
                        self?.output?.didFailPasswordSet()
                    }
                case .failure(let error):
                    print("error: \(error)")
                    self?.output?.didFailPasswordSet()
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
    
    func configure(accessRecoveryDataModel: AccessRecoveryDataModel) {
        self.accessRecoveryDataModel = accessRecoveryDataModel
    }
}

extension PasswordViewModel: PasswordCheckerServiceOutput {
    
    func didCheck(isValid: [Bool]) {
        view?.setRulesHighlighted(isValid)
    }
    
}
