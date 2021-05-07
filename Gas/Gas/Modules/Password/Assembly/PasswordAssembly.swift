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
    func didSetPassword(_ password: String)
    func didSetConfirmPassword(_ password: String)
    func didTapContinue()
}

protocol PasswordViewInput: class {
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
}

typealias PasswordModuleConfiguration = (PasswordModuleInput) -> PasswordModuleOutput?

class PasswordAssembly {
    
    func assemble(_ configuration: PasswordModuleConfiguration? = nil) -> UIViewController {
        let view = PasswordViewController()
        let passwordCheckerService = PasswordChecker()
        let viewModel = PasswordViewModel(passwordChecker: passwordCheckerService, dataProvider: AuthorizationService())
        
        view.output = viewModel
        viewModel.view = view
        
        passwordCheckerService.output = viewModel
        viewModel.output = configuration?(viewModel)
        
        return view
    }
}
