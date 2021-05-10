//
//  LoginViewModel.swift
//  Gas
//
//  Created by Strong on 5/9/21.
//

import Foundation

class LoginViewModel: LoginViewOutput {
    
    private let dataProvider: AuthorizationServiceProtocol
    private let secureAuth: SecureAuthenticationProtocol
    weak var view: LoginViewInput?
    var output: LoginModuleOutput?
    
    init(dataProvider: AuthorizationServiceProtocol,
         secureAuth: SecureAuthenticationProtocol) {
        self.dataProvider = dataProvider
        self.secureAuth = secureAuth
    }
    
    func didTapLogin(email: String, password: String) {
        dataProvider.login(phoneNumber: email, password: password) { [weak self] result in
            switch result {
            case .success(let message):
                self?.secureAuth.setToken(message.refresh)
                self?.output?.didLogin()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func didTapForgotPassword() {
        output?.didTapForgotPassword()
    }
    
}
