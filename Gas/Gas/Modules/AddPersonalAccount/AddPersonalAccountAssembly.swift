//
//  AddPersonalAccountAssembly.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

protocol AddPersonalAccountModuleOutput {
    func didTapSubmit(accountNumber: String)
}

protocol AddPersonalAccountViewInput: class {
    
}

protocol AddPersonalAccountViewOutput {
    func didTapSubmit(accountNumber: String)
}

class AddPersonalAccountAssembly {
    
    func assemble(_ moduleOutput: AddPersonalAccountModuleOutput) -> UIViewController {
        let view = AddPersonalAccountViewController()
        let viewModel = AddPersonalAccountViewModel()
        view.output = viewModel
        viewModel.view = view
        viewModel.output = moduleOutput
        return view
    }
    
}
