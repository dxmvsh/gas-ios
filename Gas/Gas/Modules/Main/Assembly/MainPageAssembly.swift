//
//  MainPageAssembly.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol MainPageRouterInput {
    func showShareActivity(for url: URL)
    func routeToReceipt(paymentId: Int, htmlCode: String)
}

class MainPageAssembly {
    
    func assemble() -> UIViewController {
        let viewModel = MainPageViewModel(paymentProvider: PaymentService())
        let analyticsView = AnalyticsAssembly().assemble()
        let accountInformationView = AccountInformationAssembly().assemble()
        let paymentHistoryView = PaymentHistoryAssembly().assemble { (input) -> PaymentHistoryModuleOutput? in
            return viewModel
        }
        let router = MainPageRouter()
        let view = MainPageViewController(analyticsView: analyticsView,
                                          accountInfoView: accountInformationView,
                                          paymentHistoryView: paymentHistoryView)
        router.viewController = view
        viewModel.router = router
        return view
    }
    
}
