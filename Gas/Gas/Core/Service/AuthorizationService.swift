//
//  AuthorizationService.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation

typealias ResponseCompletion<T> = (Result<T, GeneralError>) -> Void

protocol AuthorizationServiceProtocol {
    func getUserInformation(accountNumber: String, completion: @escaping ResponseCompletion<UserInformationDataModel>)
    func sendOTP(phoneNumber: String, completion: @escaping ResponseCompletion<MessageStatusDataModel>)
    func sendEmailOTP(email: String, completion: @escaping ResponseCompletion<MessageStatusDataModel>)
    func verify(code: String, completion: @escaping ResponseCompletion<MessageStatusDataModel>)
}

class AuthorizationService: AuthorizationServiceProtocol {
    
    private let dataProvider: NetworkDataProvider<AuthTarget>
    
    init(dataProvider: NetworkDataProvider<AuthTarget> = NetworkDataProvider<AuthTarget>()) {
        self.dataProvider = dataProvider
    }
    
    func getUserInformation(accountNumber: String, completion: @escaping ResponseCompletion<UserInformationDataModel>) {
        dataProvider.request(.accountNumber(number: accountNumber)) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(UserInformationDataModel.self, from: response.data) else {
                    completion(.failure(.custom("JSON parsing error")))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendOTP(phoneNumber: String, completion: @escaping ResponseCompletion<MessageStatusDataModel>) {
        dataProvider.request(.smsInit(phoneNumber: phoneNumber)) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(MessageStatusDataModel.self, from: response.data) else {
                    completion(.failure(.custom("JSON parsing error")))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendEmailOTP(email: String, completion: @escaping ResponseCompletion<MessageStatusDataModel>) {
        dataProvider.request(.emailInit(email: email)) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(MessageStatusDataModel.self, from: response.data) else {
                    completion(.failure(.custom("JSON parsing error")))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func verify(code: String, completion: @escaping ResponseCompletion<MessageStatusDataModel>) {
        dataProvider.request(.verify(code: code)) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(MessageStatusDataModel.self, from: response.data) else {
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
