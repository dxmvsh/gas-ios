//
//  AddPersonalAccountViewModel.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import Foundation

class AddPersonalAccountViewModel: AddPersonalAccountViewOutput {
    
    weak var view: AddPersonalAccountViewInput?
    var output: AddPersonalAccountModuleOutput?
    
    func didTapSubmit(accountNumber: String) {
        output?.didTapSubmit(accountNumber: accountNumber)
    }
}
