//
//  AddPhoneViewModel.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import Foundation

class AddPhoneViewModel: AddPhoneViewOutput {
    
    weak var view: AddPhoneViewInput?
    var output: AddPhoneModuleOutput?
    private let dataProvider: AuthorizationService
    
    init(dataProvider: AuthorizationService) {
        self.dataProvider = dataProvider
    }
    
    func didTapSubmit(with phoneNumber: String) {
        dataProvider.sendOTP(phoneToken: PhoneAuthTokenSend(mobile_phone: "+\(phoneNumber)")) { [weak self] result in
            switch result {
            case .success(let message):
                if message.message == .success {
                    self?.output?.didFinish(with: phoneNumber)
                } else {
                    print("failed phone add")
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
