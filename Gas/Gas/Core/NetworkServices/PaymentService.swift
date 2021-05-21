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
    func getPayment(id: Int, completion: @escaping ResponseCompletion<URL>)
    func calculate(data: [String: Any], completion: @escaping ResponseCompletion<CalculationDataModel>)
    func pay(params: [String: Any], completion: @escaping ResponseCompletion<String>)
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
    
    private let writer: FileWriterProtocol = FileWriter()
    
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
    
    func getPayment(id: Int, completion: @escaping ResponseCompletion<URL>) {
        dataProvider.request(.payment(id: id)) { [weak self] result in
            self?.writer.writeExportedFile(result: result) { (result) in
                switch result {
                case .success(let url):
                    completion(.success(url))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func calculate(data: [String: Any], completion: @escaping ResponseCompletion<CalculationDataModel>) {
        dataProvider.request(.calculate(data: data)) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(CalculationDataModel.self, from: response.data) else {
                    completion(.failure(.custom("JSON Parsing error")))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func pay(params: [String : Any], completion: @escaping ResponseCompletion<String>) {
        dataProvider.request(.pay(params: params)) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(PaymentUrlWrapper.self, from: response.data) else {
                    completion(.failure(.custom("JSON Parsing error")))
                    return
                }
                completion(.success(model.payment_url))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
