//
//  EmailVerificationViewModel.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import Foundation

class EmailVerificationViewModel: SmsVerificationViewOutput {
    
    weak var view: SmsVerificationViewInput?
    var output: EmailVerificationModuleOutput?
    var email: String? = nil
    
    func didLoad() {
        if let email = email {
            view?.setTitleAndSubtitleTexts(title: Text.emailVerification,
                                           subtitle: Text.enter4DigitCodeSentTo(email))
        } else {
            view?.setTitleAndSubtitleTexts(title: Text.emailVerification,
                                           subtitle: Text.enter4DigitCodeSentTo(""))
        }
        
    }
    
    func didEnterCode(_ code: String) {
        view?.setErrorStyle(message: "You failed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output?.didSucceedEmailVerification()
        }
    }
}
