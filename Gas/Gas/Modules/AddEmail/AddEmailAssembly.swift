//
//  AddEmailAssembly.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import UIKit

protocol AddEmailViewInput: class {
    
}

protocol AddEmailViewOutput {
    func didTapSubmit(with email: String)
}

protocol AddEmailModuleOutput {
    func didAdd(email: String)
}

class AddEmailAssembly {
    
    func assemble(_ moduleOutput: AddEmailModuleOutput? = nil) -> UIViewController {
        let view = AddEmailViewController()
        let dataProvider = AuthorizationService()
        let viewModel = AddEmailViewModel(dataProvider: dataProvider)
        viewModel.view = view
        view.output = viewModel
        viewModel.output = moduleOutput
        return view
    }
    
    func assembleForChangeEmail(_ moduleOutput: AddEmailModuleOutput? = nil) -> UIViewController {
        let view = AddEmailViewController()
        let dataProvider = AuthorizationService()
        let viewModel = AddEmailViewModel(dataProvider: dataProvider)
        view.setTitleAndSubtitle(title: "Эл. почта", subtitle: "Введите новый электронный адрес")
        viewModel.view = view
        view.output = viewModel
        viewModel.output = moduleOutput
        return view
    }
}
