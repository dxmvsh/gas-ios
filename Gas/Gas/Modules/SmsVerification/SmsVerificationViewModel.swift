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
    var phoneNumber: String?
    
    private let dataProvider: AuthorizationService
    var changesNumber: Bool = false
    private let secureAuth = SecureAuthentication(dataProvider: AuthorizationService())
    init(dataProvider: AuthorizationService) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() { }
    
    func didEnterCode(_ code: String) {
        if changesNumber {
            changeNumber(code: code)
            return
        }
        dataProvider.verify(code: code) { [weak self] result in
            switch result {
            case .success(let message):
                if message.message == .success, let phoneNumber = self?.phoneNumber {
                    self?.output?.didSucceed(phoneNumber: phoneNumber)
                } else {
                    self?.view?.setErrorStyle(message: Text.invalidCode)
                }
            case .failure(let error):
                self?.output?.didFail()
            }
        }
    }
    
    func changeNumber(code: String) {
        guard let phoneNumber = phoneNumber else { return }
        dataProvider.changePhoneNumber(phoneNumber: phoneNumber, code: code) { [weak self] result in
            switch result {
            case .success(let message):
                if message.message == .success, let phoneNumber = self?.phoneNumber {
                    self?.output?.didSucceed(phoneNumber: phoneNumber)
                    self?.secureAuth.setEmail(phoneNumber)
                } else {
                    self?.view?.setErrorStyle(message: Text.invalidCode)
                }
            case .failure(let error):
                self?.output?.didFail()
            }
        }
    }
}
