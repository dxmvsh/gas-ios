//
//  PaymentOrderViewModel.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import Foundation

class PaymentOrderViewModel: PaymentOrderViewOutput, PaymentOrderModuleInput {
    
    weak var view: PaymentOrderViewInput?
    var moduleOutput: PaymentOrderModuleOutput?
    var router: PaymentOrderRouterInput?
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
//        router?.routeToScan(completion: { [weak self] result in
//            guard let indicator = Double(result as String) else { return }
//            self?.didSetIndicator(Int(indicator))
//        })
    }
    
    func didSetIndicator(_ indicator: Int) {
        payload.current_indicators = Decimal(indicator)
        guard payload.current_indicators != nil,
              payload.last_indicators != nil,
              payload.account_number != nil else { return }
        dataProvider.calculate(data: payload.toDict()) { [weak self] result in
            switch result {
            case .success(let model):
                self?.payload.principal = model.amount
                self?.view?.display(calculation: model)
                self?.view?.set(currentIndicator: "\(Decimal(indicator)) \(UnitVolume.cubicMeters.symbol)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func didTapScan() {
        router?.routeToScan(completion: { [weak self] result in
            guard let indicator = Double(result as String) else { return }
            self?.didSetIndicator(Int(indicator))
        })
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
    
    func didTapPay() {
        guard payload.current_indicators != nil,
              payload.account_number != nil,
              payload.principal != nil else { return }
        
        dataProvider.pay(params: payload.toDict()) { [weak self] result in
            switch result {
            case .success:
                self?.router?.showResultViewController(isSuccess: true,
                                                       title: "Успешно оплачено!",
                                                       subtitle: "",
                                                       image: Asset.checkMark.image,
                                                       completion: { [weak self] in
                                                        self?.moduleOutput?.didSucceedPayment()
                                                       })
            case .failure:
                self?.router?.showResultViewController(isSuccess: false,
                                                       title: "Ошибка",
                                                       subtitle: "Попробуйте еще раз",
                                                       image: Asset.rpFail.image,
                                                       completion: { [weak self] in
                                                        self?.moduleOutput?.didSucceedPayment()
                                                       })
            }
        }
    }
    
}
