//
//  SmsVerificationAssembly.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import UIKit

protocol SmsVerificationViewInput: class {
    func setErrorStyle(message: String)
}

protocol SmsVerificationViewOutput {
    func didEnterCode(_ code: String)
}

protocol SmsVerificationModuleOutput {
    func didSucceed()
    func didFail()
}

class SmsVerificationAssembly {
    
    func assemble(_ moduleOutput: SmsVerificationModuleOutput? = nil) -> UIViewController {
        let view = SmsVerificationViewController()
        let viewModel = SmsVerificationViewModel()
        
        view.output = viewModel
        viewModel.view = view
        viewModel.output = moduleOutput
        
        
        return view
    }
    
}
