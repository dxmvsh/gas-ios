//
//  PaymentService.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Foundation
import Moya

protocol PaymentServiceProtocol {
    func getHistory(dateFrom: String?, dateTo: String?, completion: @escaping ResponseCompletion<[PaymentHistoryItemDataModel]>)
    func getPayment(id: Int, completion: @escaping ResponseCompletion<PaymentHistoryItemDataModel>)
}

class PaymentService: PaymentServiceProtocol {
    
    private let dataProvider = NetworkDataProvider<PaymentTarget>(plugins: [
        NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(formatter: NetworkLoggerPlugin.Configuration.Formatter(),
                                                                                                      output: NetworkLoggerPlugin.Configuration.defaultOutput(target:items:),
                                                                                                      logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose)),
        AccessTokenPlugin(tokenClosure: { type -> String in
            switch type {
            case .basic, .bearer:
                return ""
            case .custom:
                return "\(AuthTokenStorage.shared.getToken())"
            }
        })
    ])
    
    func getHistory(dateFrom: String?, dateTo: String?, completion: @escaping ResponseCompletion<[PaymentHistoryItemDataModel]>) {
        dataProvider.request(.history(from: dateFrom, to: dateTo)) { result in
            switch result {
            case .success(let response):
                guard let models = try? JSONDecoder().decode([PaymentHistoryItemDataModel].self, from: response.data) else {
                    completion(.failure(.custom("JSON parsing error")))
                    return
                }
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPayment(id: Int, completion: @escaping ResponseCompletion<PaymentHistoryItemDataModel>) {
        dataProvider.request(.payment(id: id)) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(PaymentHistoryItemDataModel.self, from: response.data) else {
                    completion(.failure(.custom("JSON parsing error")))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
