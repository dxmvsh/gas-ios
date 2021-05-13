//
//  MainPageViewModel.swift
//  Gas
//
//  Created by Strong on 5/12/21.
//

import Foundation

class MainPageViewModel: PaymentHistoryModuleOutput {
    
    private let paymentProvider: PaymentServiceProtocol
    
    init(paymentProvider: PaymentServiceProtocol) {
        self.paymentProvider = paymentProvider
    }
    
    func didSelect(paymentId: Int) {
        paymentProvider.getPayment(id: paymentId) { result in
            switch result {
            case .success(let model):
                print("payment: \(model)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
