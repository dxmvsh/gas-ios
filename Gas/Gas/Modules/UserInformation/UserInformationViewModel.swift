//
//  UserInformationViewModel.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import Foundation

class UserInformationViewModel: UserInformationViewOutput, UserInformationModuleInput {
    
    private var accountNumber: String?
    
    weak var view: UserInformationViewInput?
    var output: UserInformationModuleOutput?
    
    func didLoad() {
        view?.display(UserInformationDataModel(fio: "Алмас Рахимов",
                                               accountNumber: "10050030",
                                               city: "Кокшетау",
                                               address: "Kurmangazy 43/65"))
    }
    
    func didTapSubmit(_ userInfo: UserInformationDataModel) {
        output?.didTapSubmit(userInfo)
    }
    
    func setAccountNumber(_ accountNumber: String) {
        self.accountNumber = accountNumber
    }
    
}
