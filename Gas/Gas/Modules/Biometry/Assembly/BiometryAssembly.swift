//
//  BiometryAssembly.swift
//  Gas
//
//  Created by Strong on 4/29/21.
//

import UIKit

protocol BiometryViewOutput {
    func didTapPrimaryButton()
    func didTapSecondaryButton()
}

protocol BiometryModuleOutput {
    func didSucceedBiometry()
    func didFailBiometry()
}

class BiometryAssembly {
    
    func assemble(_ moduleOutput: BiometryModuleOutput? = nil) -> UIViewController {
        let view = BiometryViewController()
        let viewModel = BiometryViewModel(secureAuth: SecureAuthentication(dataProvider: AuthorizationService()))
        
        view.output = viewModel
        viewModel.output = moduleOutput
        
        return view
    }
    
}
