//
//  MainPageViewModel.swift
//  Gas
//
//  Created by Strong on 5/12/21.
//

import Foundation

class MainPageViewModel: PaymentHistoryModuleOutput {
    
    private let paymentProvider: PaymentServiceProtocol
    var router: MainPageRouterInput?
    init(paymentProvider: PaymentServiceProtocol) {
        self.paymentProvider = paymentProvider
    }
    
    func didSelect(paymentId: Int) {
        paymentProvider.getPaymentWeb(id: paymentId) { [weak self] result in
            switch result {
            case .success(let html):
                self?.router?.routeToReceipt(paymentId: paymentId, htmlCode: html)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
