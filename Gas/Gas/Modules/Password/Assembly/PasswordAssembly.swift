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
    
}

class PasswordAssembly {
    
    func assemble(_ moduleOutput: PasswordModuleOutput? = nil) -> UIViewController {
        let view = PasswordViewController()
        let passwordCheckerService = PasswordChecker()
        let viewModel = PasswordViewModel(passwordChecker: passwordCheckerService)
        
        view.output = viewModel
        viewModel.view = view
        
        passwordCheckerService.output = viewModel
        viewModel.output = moduleOutput
        
        return view
    }
}
