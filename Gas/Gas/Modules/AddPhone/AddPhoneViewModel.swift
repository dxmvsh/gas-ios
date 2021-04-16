//
//  AddPhoneViewModel.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import Foundation

class AddPhoneViewModel: AddPhoneViewOutput {
    
    weak var view: AddPhoneViewInput?
    var output: AddPhoneModuleOutput?
    
    func didTapSubmit(with phoneNumber: String) {
        output?.didFinish(with: phoneNumber)
    }
    
}
