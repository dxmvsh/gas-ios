//
//  PasswordAssembly.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

protocol PasswordViewOutput {
    func didLoad()
    func didChangePassword(_ password: String)
    func didSetOldPassword(_ password: String)
    func didSetPassword(_ password: String)
    func didSetConfirmPassword(_ password: String)
    func didTapContinue()
}

protocol PasswordViewInput: class {
    func setOldPassword(isHidden: Bool)
    func setPasswordRules(_ rules: [PasswordRuleViewAdapter])
    func setRulesHighlighted(_ highlighted: [Bool])
    func setButton(active: Bool)
    func showConfirmPasswordError(_ message: String)
}

protocol PasswordModuleOutput {
    func didSucceedPasswordSet()
    func didFailPasswordSet()
}

protocol PasswordModuleInput: class {
    func configure(userDataModel: UserDataModel)
    func configure(accessRecoveryDataModel: AccessRecoveryDataModel)
}

typealias PasswordModuleConfiguration = (PasswordModuleInput) -> PasswordModuleOutput?

class PasswordAssembly {
    
    func assemble(mode: PasswordMode, _ configuration: PasswordModuleConfiguration? = nil) -> UIViewController {
        let view = PasswordViewController()
        let passwordCheckerService = PasswordChecker()
        let viewModel = PasswordViewModel(mode: mode,
                                          passwordChecker: passwordCheckerService,
                                          dataProvider: AuthorizationService(),
                                          secureAuthService: SecureAuthentication(dataProvider: AuthorizationService()))
        
        view.output = viewModel
        viewModel.view = view
        
        passwordCheckerService.output = viewModel
        viewModel.output = configuration?(viewModel)
        
        return view
    }
}
