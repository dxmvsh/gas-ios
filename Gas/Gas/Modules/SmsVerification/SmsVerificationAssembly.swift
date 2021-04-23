//
//  SmsVerificationAssembly.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import UIKit

protocol SmsVerificationViewInput: class {
    func setErrorStyle(message: String)
    func setTitleAndSubtitleTexts(title: String, subtitle: String)
}

protocol SmsVerificationViewOutput {
    func didLoad()
    func didEnterCode(_ code: String)
}

protocol SmsVerificationModuleOutput {
    func didSucceed()
    func didFail()
}

protocol EmailVerificationModuleOutput {
    func didSucceedEmailVerification()
    func didFailEmailVerification()
}

class SmsVerificationAssembly {
    
    func assemblePhone(_ moduleOutput: SmsVerificationModuleOutput? = nil) -> UIViewController {
        let view = SmsVerificationViewController()
        let viewModel = SmsVerificationViewModel()
        
        view.output = viewModel
        viewModel.view = view
        viewModel.output = moduleOutput
        
        return view
    }
    
    func assembleEmail(_ moduleOutput: EmailVerificationModuleOutput? = nil, email: String) -> UIViewController {
        let view = SmsVerificationViewController()
        let viewModel = EmailVerificationViewModel()
        
        view.output = viewModel
        viewModel.view = view
        viewModel.output = moduleOutput
        viewModel.email = email
        
        return view
    }
}
