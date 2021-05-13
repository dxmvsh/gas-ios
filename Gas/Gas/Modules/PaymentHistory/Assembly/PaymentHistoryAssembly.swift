//
//  PaymentHistoryAssembly.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol PaymentHistoryViewInput: class {
    func display(adapters: [PaymentHistoryCellAdapter])
    func setUserInteractionEnabled(_ enabled: Bool)
}

protocol PaymentHistoryViewOutput {
    func didLoad()
    func didSelectPayment(at index: Int)
}

protocol PaymentHistoryModuleInput {
    func setUserInteractionEnabled(_ enabled: Bool)
}

protocol PaymentHistoryModuleOutput {
    func didSelect(paymentId: Int)
}

typealias PaymentHistoryConfiguration = (PaymentHistoryModuleInput) -> PaymentHistoryModuleOutput?

class PaymentHistoryAssembly {
    
    func assemble(_ configuration: PaymentHistoryConfiguration? = nil) -> UIViewController {
        let view = PaymentHistoryViewController()
        let viewModel = PaymentHistoryViewModel(dataProvider: PaymentService())
        
        view.output = viewModel
        viewModel.view = view
        viewModel.output = configuration?(viewModel)
        
        return view
    }
    
}
