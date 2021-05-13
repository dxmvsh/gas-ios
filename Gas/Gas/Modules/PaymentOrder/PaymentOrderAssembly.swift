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
    func didTapPay()
}

protocol PaymentOrderModuleOutput {
    func didSucceedPayment()
    func didFailPayment()
}

protocol PaymentOrderModuleInput {
    func configure(account: AccountInformationDataModel)
    func configure(history: [PaymentHistoryItemDataModel])
}

protocol PaymentOrderRouterInput {
    func showResultViewController(isSuccess: Bool,
                                  title: String,
                                  subtitle: String,
                                  image: UIImage,
                                  completion: @escaping (() -> Void))
}

typealias PaymentOrderConfiguration = (PaymentOrderModuleInput) -> PaymentOrderModuleOutput?

class PaymentOrderAssembly {
    
    func assemble(_ configuration: PaymentOrderConfiguration? = nil) -> UIViewController {
        let view = PaymentOrderViewController()
        let viewModel = PaymentOrderViewModel(dataProvider: PaymentService())
        let router = PaymentOrderRouter()
        
        router.viewController = view
        viewModel.router = router
        viewModel.view = view
        view.output = viewModel
        viewModel.moduleOutput = configuration?(viewModel)
        
        return view
    }
    
}
