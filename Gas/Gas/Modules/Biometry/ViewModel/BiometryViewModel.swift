//
//  BiometryViewModel.swift
//  Gas
//
//  Created by Strong on 4/29/21.
//

import Foundation

class BiometryViewModel: BiometryViewOutput {
    
    var output: BiometryModuleOutput?
    
    func didTapPrimaryButton() {
        output?.didSucceedBiometry()
    }
    
    func didTapSecondaryButton() {
        output?.didFailBiometry()
    }
    
}
