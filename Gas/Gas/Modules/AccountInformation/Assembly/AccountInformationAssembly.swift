//
//  AccountInformationAssembly.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import UIKit

protocol AccountInformationViewInput: class {
    func display(adapter: AccountInformationDataModel)
}

protocol AccountInformationViewOutput {
    func didLoad()
}

protocol AccountInformationModuleOutput {
    
}

class AccountInformationAssembly {
    
    func assemble(_ output: AccountInformationModuleOutput? = nil) -> UIViewController {
        let view = AccountInformationViewController()
        let viewModel = AccountInformationViewModel(dataProvider: UserService())
        
        view.output = viewModel
        viewModel.view = view
        viewModel.output = output
        
        return view
    }
}
