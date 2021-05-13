//
//  AccountListViewModel.swift
//  Gas
//
//  Created by Strong on 5/12/21.
//

import Foundation

class AccountListViewModel: AccountListViewOutput {
    
    var output: AccountListModuleOutput?
    weak var view: AccountListViewInput?
    
    private let dataProvider: UserServiceProtocol
    private var models: [AccountInformationDataModel] = []
    
    init(dataProvider: UserServiceProtocol) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() {
        dataProvider.getInformation { [weak self] result in
            switch result {
            case .success(let models):
                self?.models = models
                self?.view?.display(models: models)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func didTapAddAccount() {
        output?.didTapAddAccount()
    }
    
    func didSelectAccount(at index: Int) {
        let account = models[index]
        output?.didSelectAccount(account)
    }
}
