//
//  LoginAssembly.swift
//  Gas
//
//  Created by Strong on 5/9/21.
//

import UIKit

protocol LoginModuleOutput {
    func didLogin()
}

protocol LoginViewOutput {
    func didTapLogin(email: String, password: String)
}

protocol LoginViewInput: class {
    
}

class LoginAssembly {
    
    func assemble(_ output: LoginModuleOutput? = nil) -> UIViewController {
        let view = LoginViewController()
        let dataProvider = AuthorizationService()
        let secureAuth = SecureAuthentication(dataProvider: AuthorizationService())
        let viewModel = LoginViewModel(dataProvider: dataProvider, secureAuth: secureAuth)
        
        view.output = viewModel
        viewModel.view = view
        viewModel.output = output
        
        return view
    }
    
}
