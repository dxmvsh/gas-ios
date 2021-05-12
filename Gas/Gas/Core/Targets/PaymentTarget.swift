//
//  PaymentTarget.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Moya

enum PaymentTarget: TargetType, AccessTokenAuthorizable {
    
    case history(from: String?, to: String?)
    case payment(id: Int)
    
    var baseURL: URL {
        URL(string: AppConfigs.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .history:
            return "payment/history/"
        case .payment(let id):
            return "payment/history/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .history, .payment:
            return .get
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .history(let from, let to):
            var params: [String: Any] = [:]
            if let from = from {
                params["date_from"] = from
            }
            if let to = to {
                params["date_to"] = to
            }
            return .requestParameters(parameters: params, encoding: QueryEncoding.default)
        case .payment:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
    
    var authorizationType: AuthorizationType? { .custom("JWT") }
}
