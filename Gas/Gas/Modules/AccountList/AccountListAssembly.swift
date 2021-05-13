//
//  AccountListAssembly.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

protocol AccountListViewInput: class {
    func display(models: [AccountInformationDataModel])
}

protocol AccountListViewOutput {
    func didLoad()
    func didTapAddAccount()
    func didSelectAccount(at index: Int)
}

protocol AccountListModuleOutput {
    func didTapAddAccount()
    func didSelectAccount(_ account: AccountInformationDataModel)
}

class AccountListAssembly {
    
    func assemble() -> UIViewController {
        let view = AccountListViewController()
        let viewModel = AccountListViewModel(dataProvider: UserService())
        
        view.output = viewModel
        viewModel.view = view
        
        return view
    }
    
}
