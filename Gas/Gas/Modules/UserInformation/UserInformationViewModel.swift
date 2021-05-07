//
//  UserInformationViewModel.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import Foundation

class UserInformationViewModel: UserInformationViewOutput, UserInformationModuleInput {
    
    private var accountNumber: String?
    private let dataProvider: AuthorizationService
    
    weak var view: UserInformationViewInput?
    var output: UserInformationModuleOutput?
    private var userInfo = UserInformationDataModel(full_name: "Алмас Рахимов",
                                                    number: "10050030",
                                                    city: "Кокшетау",
                                                    address: "Kurmangazy 43/65")
    
    init(dataProvider: AuthorizationService) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() {
        guard let accountNumber = accountNumber else { return }
        dataProvider.getUserInformation(accountNumber: accountNumber) { [weak self] result in
            switch result {
            case .success(let model):
                self?.view?.display(model)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func didTapSubmit() {
        output?.didTapSubmit(userInfo)
    }
    
    func setAccountNumber(_ accountNumber: String) {
        self.accountNumber = accountNumber
    }
    
}
