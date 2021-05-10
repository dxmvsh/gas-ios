//
//  AnalyticsAssembly.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol AnalyticsViewInput: class {
    func display(adapter: AnalyticsViewAdapter)
}

protocol AnalyticsViewOutput {
    func didLoad()
}

protocol AnalyticsModuleOutput {
    
}

class AnalyticsAssembly {
    
    func assemble(_ output: AnalyticsModuleOutput? = nil) -> UIViewController {
        let view = AnalyticsViewController()
        let viewModel = AnalyticsViewModel(dataProvider: UserService())
        
        viewModel.view = view
        view.output = viewModel
        viewModel.output = output
        
        return view
    }
    
}
