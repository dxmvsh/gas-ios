//
//  AnalyticsAssembly.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol AnalyticsViewInput: class {
    
}

protocol AnalyticsViewOutput {
    
}

protocol AnalyticsModuleOutput {
    
}

class AnalyticsAssembly {
    
    func assemble(_ output: AnalyticsModuleOutput? = nil) -> UIViewController {
        let view = AnalyticsViewController()
        let viewModel = AnalyticsViewModel()
        
        viewModel.view = view
        view.output = viewModel
        viewModel.output = output
        
        return view
    }
    
}
