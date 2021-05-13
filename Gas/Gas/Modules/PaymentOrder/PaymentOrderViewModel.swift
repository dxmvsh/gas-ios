//
//  PaymentOrderViewModel.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import Foundation

class PaymentOrderViewModel: PaymentOrderViewOutput, PaymentOrderModuleInput {
    
    weak var view: PaymentOrderViewInput?
    private let dataProvider: PaymentServiceProtocol
    private let accountProvider: UserServiceProtocol = UserService()
    private var account: AccountInformationDataModel?
    private var payload = CalculationRequestDataModel()
    
    init(dataProvider: PaymentServiceProtocol) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() {
        dataProvider.getHistory(dateFrom: nil, dateTo: nil) { [weak self] result in
            switch result {
            case .success(let payments):
                self?.configure(history: payments)
            case .failure(let error):
                print("error: \(error)")
            }
        }
        accountProvider.getInformation { [weak self] result in
            switch result {
            case .success(let accounts):
                self?.configure(account: accounts[0])
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func didSetIndicator(_ indicator: Int) {
        payload.current_indicators = Decimal(indicator)
        guard payload.current_indicators != nil,
              payload.last_indicators != nil,
              payload.account_number != nil else { return }
        dataProvider.calculate(data: payload.toDict()) { [weak self] result in
            switch result {
            case .success(let model):
                self?.view?.display(calculation: model)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func configure(account: AccountInformationDataModel) {
        self.account = account
        payload.account_number = account.number
        view?.display(account: account)
    }
    
    func configure(history: [PaymentHistoryItemDataModel]) {
        var lastIndicator: Decimal = 0
        history.forEach({ lastIndicator = max($0.volume, lastIndicator) })
        payload.last_indicators = lastIndicator
        view?.set(lastIndicator: "\(lastIndicator)")
    }
    
}
