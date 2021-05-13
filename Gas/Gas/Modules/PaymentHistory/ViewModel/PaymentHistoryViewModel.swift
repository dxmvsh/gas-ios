//
//  PaymentHistoryViewModel.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Foundation

class PaymentHistoryViewModel: PaymentHistoryViewOutput, PaymentHistoryModuleInput {
    
    weak var view: PaymentHistoryViewInput?
    var output: PaymentHistoryModuleOutput?
    private let dataProvider: PaymentServiceProtocol
    private var payments: [PaymentHistoryItemDataModel] = []
    init(dataProvider: PaymentServiceProtocol) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() {
        dataProvider.getHistory(dateFrom: nil, dateTo: nil) { [weak self] result in
            switch result {
            case .success(let models):
                let adapters = models.compactMap { model -> PaymentHistoryCellAdapter? in
                    return PaymentHistoryCellAdapter(data: model)
                }
                self?.view?.display(adapters: adapters)
                self?.payments = models
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func setUserInteractionEnabled(_ enabled: Bool) {
        view?.setUserInteractionEnabled(enabled)
    }
    
    func didSelectPayment(at index: Int) {
        output?.didSelect(paymentId: payments[index].id)
    }
}
