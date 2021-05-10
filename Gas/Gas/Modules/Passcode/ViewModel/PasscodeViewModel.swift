//
//  PasscodeViewModel.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import Foundation

class PasscodeViewModel: PasscodeViewOutput {
    
    weak var view: PasscodeViewInput?
    var output: PasscodeModuleOutput?
    
    private let secureAuth: SecureAuthenticationProtocol
    private let mode: PasscodeMode
    init(mode: PasscodeMode, secureAuth: SecureAuthenticationProtocol) {
        self.mode = mode
        self.secureAuth = secureAuth
    }
    
    func didEnterPasscode(_ code: String) {
        switch mode {
        case .set:
            let firstPasscode = code.prefix(4)
            let secondPasscode = code.suffix(4)
            if firstPasscode == secondPasscode {
                secureAuth.setPasscode(String(firstPasscode))
                output?.didSucceedPasscodeModule()
            } else {
                view?.showError()
            }
        case .enter:
            secureAuth.authenticateWithPasscode(code) { [weak self] (success) in
                if success {
                    self?.output?.didSucceedPasscodeModule()
                } else {
                    // TODO: Show alert to enter via email password
                }
            }
        }
    }
    
}
