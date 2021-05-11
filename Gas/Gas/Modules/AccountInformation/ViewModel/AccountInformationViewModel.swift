//
//  AccountInformationViewModel.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Foundation

class AccountInformationViewModel: AccountInformationViewOutput {
    
    weak var view: AccountInformationViewInput?
    var output: AccountInformationModuleOutput?
    
    private let dataProvider: UserServiceProtocol
    
    init(dataProvider: UserServiceProtocol) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() {
        dataProvider.getInformation { [weak self] result in
            switch result {
            case .success(let model):
                self?.view?.display(adapter: model[0])
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
