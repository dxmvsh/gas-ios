//
//  UserInformationAssembly.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

protocol UserInformationModuleInput: class {
    func setAccountNumber(_ accountNumber: String)
}

protocol UserInformationModuleOutput {
    func didTapSubmit(_ userInfo: UserInformationDataModel)
}

protocol UserInformationViewInput: class {
    func display(_ userInfo: UserInformationDataModel)
}

protocol UserInformationViewOutput {
    func didLoad()
    func didTapSubmit(_ userInfo: UserInformationDataModel)
}

typealias UserInformationConfiguration = (UserInformationModuleInput) -> UserInformationModuleOutput?

class UserInformationAssembly {
    
    func assemble(_ configuration: UserInformationConfiguration? = nil) -> UIViewController {
        let view = UserInformationViewController()
        let viewModel = UserInformationViewModel()
        viewModel.view = view
        view.output = viewModel
        viewModel.output = configuration?(viewModel)
        return view
    }
    
}