//
//  CommonService.swift
//  Gas
//
//  Created by Strong on 5/21/21.
//

import Moya

class CommonService {
    private let dataProvider = NetworkDataProvider<CommonTarget>(plugins: [
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
    
    func sendComment(message: String, completion: @escaping ResponseCompletion<MessageWrapped>) {
        dataProvider.request(.contactSupport(message: message)) { result in
            switch result {
            case .success(let response):
                guard let message = try? JSONDecoder().decode(MessageWrapped.self, from: response.data) else {
                    completion(.failure(.custom("JSON parsing error")))
                    return
                }
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
