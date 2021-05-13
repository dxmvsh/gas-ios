//
//  PasscodeAssembly.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

protocol PasscodeViewOutput {
    func didEnterPasscode(_ code: String)
    func didTapBack()
}

protocol PasscodeViewInput: class {
    func showError()
}

protocol PasscodeModuleOutput {
    
    func didSucceedPasscodeModule()
    func didFailPasscodeModule()
    
}

class PasscodeAssembly {
    
    func assemble(mode: PasscodeMode, _ moduleOutput: PasscodeModuleOutput) -> UIViewController {
        let view = PasscodeViewController(mode: mode)
        let viewModel = PasscodeViewModel(mode: mode, secureAuth: SecureAuthentication(dataProvider: AuthorizationService()))
        
        view.output = viewModel
        viewModel.view = view
        viewModel.output = moduleOutput
        
        return view
    }
    
}
