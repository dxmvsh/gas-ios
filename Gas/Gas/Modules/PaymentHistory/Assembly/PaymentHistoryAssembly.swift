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
    func didTapFilter()
}

extension PaymentHistoryViewOutput {
    func didTapFilter() {}
}

protocol PaymentHistoryModuleInput {
    func setUserInteractionEnabled(_ enabled: Bool)
}

protocol PaymentHistoryModuleOutput {
    func didSelect(paymentId: Int)
}

protocol PaymentHistoryRouterInput {
    func showFiltrationModule(filterType: PaymentListFilterType, submitHandler: @escaping ((PaymentListFilterType) -> Void))
    func showShareActivity(for url: URL)
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
    
    func assembleList(_ configuration: PaymentHistoryConfiguration? = nil) -> UIViewController {
        let view = PaymentListViewController()
        let viewModel = PaymentHistoryViewModel(dataProvider: PaymentService())
        let router = PaymentHistoryRouter()
        
        router.viewController = view
        view.output = viewModel
        viewModel.view = view
        viewModel.output = configuration?(viewModel)
        viewModel.router = router
        
        return view
    }
    
}
