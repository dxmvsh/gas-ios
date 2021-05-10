//
//  UserService.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import Moya

protocol UserServiceProtocol {
    func getAnalytics(completion: @escaping ResponseCompletion<AnalyticsDataModel>)
}

class UserService: UserServiceProtocol {
    
    private let dataProvider: NetworkDataProvider<UserTarget> = NetworkDataProvider<UserTarget>(plugins: [
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
    
    func getAnalytics(completion: @escaping ResponseCompletion<AnalyticsDataModel>) {
        dataProvider.request(.analytics) { result in
            switch result {
            case .success(let response):
                guard let model = try? JSONDecoder().decode(AnalyticsDataModel.self, from: response.data) else {
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
