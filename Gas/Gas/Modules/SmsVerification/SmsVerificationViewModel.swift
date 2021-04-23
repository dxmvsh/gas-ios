//
//  SmsVerificationViewModel.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import Foundation

class SmsVerificationViewModel: SmsVerificationViewOutput {
    
    weak var view: SmsVerificationViewInput?
    var output: SmsVerificationModuleOutput?
    
    func didLoad() { }
    
    func didEnterCode(_ code: String) {
        view?.setErrorStyle(message: "You failed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output?.didSucceed()
        }
    }
}
