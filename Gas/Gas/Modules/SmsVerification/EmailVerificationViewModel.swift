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
    
    private let dataProvider: AuthorizationService
    
    init(dataProvider: AuthorizationService) {
        self.dataProvider = dataProvider
    }
    
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
        dataProvider.verify(code: code) { [weak self] result in
            switch result {
            case .success(let message):
                if message.message == .success {
                    self?.output?.didSucceedEmailVerification()
                } else {
                    self?.view?.setErrorStyle(message: Text.invalidCode)
                }
            case .failure(let error):
                self?.output?.didFailEmailVerification()
            }
        }
    }
}
