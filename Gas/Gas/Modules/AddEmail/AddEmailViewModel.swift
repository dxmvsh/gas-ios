//
//  AddEmailViewModel.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import Foundation

class AddEmailViewModel: AddEmailViewOutput {
    
    weak var view: AddEmailViewInput?
    var output: AddEmailModuleOutput?
    
    private let dataProvider: AuthorizationService
    
    init(dataProvider: AuthorizationService) {
        self.dataProvider = dataProvider
    }
    
    func didTapSubmit(with email: String) {
        dataProvider.sendEmailOTP(email: email) { [weak self] result in
            switch result {
            case .success(let message):
                if message.message == .success {
                    self?.output?.didAdd(email: email)
                } else {
                    print("did not add email")
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
