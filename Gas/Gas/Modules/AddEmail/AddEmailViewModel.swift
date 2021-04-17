//
//  AddEmailViewModel.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import Foundation

class AddEmailViewModel: AddEmailViewOutput {
    
    weak var view: AddEmailViewInput?
    var output: AddEmailModuleOutput?
    
    
    func didTapSubmit(with email: String) {
        output?.didAdd(email: email)
    }
    
}
