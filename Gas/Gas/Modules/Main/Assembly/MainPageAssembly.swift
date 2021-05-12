//
//  MainPageAssembly.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

class MainPageAssembly {
    
    func assemble() -> UIViewController {
        let viewModel = MainPageViewModel(paymentProvider: PaymentService())
        let analyticsView = AnalyticsAssembly().assemble()
        let accountInformationView = AccountInformationAssembly().assemble()
        let paymentHistoryView = PaymentHistoryAssembly().assemble { (input) -> PaymentHistoryModuleOutput? in
            return viewModel
        }
        let view = MainPageViewController(analyticsView: analyticsView,
                                          accountInfoView: accountInformationView,
                                          paymentHistoryView: paymentHistoryView)
        
        
        return view
    }
    
}
