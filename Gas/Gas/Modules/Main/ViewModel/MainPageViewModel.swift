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
        paymentProvider.getPayment(id: paymentId) { [weak self] result in
            switch result {
            case .success(let url):
                self?.router?.showShareActivity(for: url)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
