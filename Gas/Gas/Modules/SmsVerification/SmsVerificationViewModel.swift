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
    
    private let dataProvider: AuthorizationService
    
    init(dataProvider: AuthorizationService) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() { }
    
    func didEnterCode(_ code: String) {
        dataProvider.verify(code: code) { [weak self] result in
            switch result {
            case .success(let message):
                if message.message == .success {
                    self?.output?.didSucceed()
                } else {
                    self?.view?.setErrorStyle(message: Text.invalidCode)
                }
            case .failure(let error):
                self?.output?.didFail()
            }
        }
    }
}
