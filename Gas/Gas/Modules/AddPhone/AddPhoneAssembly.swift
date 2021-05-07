//
//  AddPhoneAssembly.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

protocol AddPhoneViewInput: class {
    
}

protocol AddPhoneViewOutput {
    func didTapSubmit(with phoneNumber: String)
}

protocol AddPhoneModuleOutput {
    func didFinish(with phoneNumber: String)
}

class AddPhoneAssembly {
    
    func assemble(_ moduleOutput: AddPhoneModuleOutput? = nil) -> UIViewController {
        let view = AddPhoneViewController()
        let dataProvider = AuthorizationService()
        let viewModel = AddPhoneViewModel(dataProvider: dataProvider)
        viewModel.view = view
        view.output = viewModel
        viewModel.output = moduleOutput
        return view
    }
    
}
