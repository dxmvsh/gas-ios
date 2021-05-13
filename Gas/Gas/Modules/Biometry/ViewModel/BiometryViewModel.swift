//
//  BiometryViewModel.swift
//  Gas
//
//  Created by Strong on 4/29/21.
//

import Foundation

class BiometryViewModel: BiometryViewOutput {
    
    var output: BiometryModuleOutput?
    private let secureAuth: SecureAuthenticationProtocol
    
    init(secureAuth: SecureAuthenticationProtocol) {
        self.secureAuth = secureAuth
    }
    
    func didTapPrimaryButton() {
        secureAuth.setBiometry()
        output?.didSucceedBiometry()
    }
    
    func didTapSecondaryButton() {
        output?.didFailBiometry()
    }
    
}
