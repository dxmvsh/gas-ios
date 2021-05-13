//
//  PaymentOrderAssembly.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

protocol PaymentOrderViewInput: class {
    func display(account: AccountInformationDataModel)
    func display(calculation: CalculationDataModel)
    func set(lastIndicator: String)
}

protocol PaymentOrderViewOutput {
    func didLoad()
    func didSetIndicator(_ indicator: Int)
}

protocol PaymentOrderModuleOutput {
    
}

protocol PaymentOrderModuleInput {
    func configure(account: AccountInformationDataModel)
    func configure(history: [PaymentHistoryItemDataModel])
}

typealias PaymentOrderConfiguration = (PaymentOrderModuleInput) -> PaymentOrderModuleOutput?

class PaymentOrderAssembly {
    
    func assemble(_ configuration: PaymentOrderConfiguration? = nil) -> UIViewController {
        let view = PaymentOrderViewController()
        let viewModel = PaymentOrderViewModel(dataProvider: PaymentService())
        
        viewModel.view = view
        view.output = viewModel
        
        return view
    }
    
}
