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
    case paymentWeb(id: Int)
    case calculate(data: [String: Any])
    case pay(params: [String: Any])
    
    var baseURL: URL {
        URL(string: AppConfigs.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .history:
            return "payment/history/"
        case .payment(let id):
            return "payment/history/\(id)/download/"
        case .paymentWeb(let id):
            return "payment/history/\(id)/"
        case .calculate:
            return "payment/calculate"
        case .pay:
            return "payment/pay/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .history, .payment, .calculate, .paymentWeb:
            return .get
        case .pay:
            return .post
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .calculate(let data):
            return .requestParameters(parameters: data, encoding: QueryEncoding.default)
        case .history(let from, let to):
            var params: [String: Any] = [:]
            if let from = from {
                params["date_from"] = from
            }
            if let to = to {
                params["date_to"] = to
            }
            return .requestParameters(parameters: params, encoding: QueryEncoding.default)
        case .payment, .paymentWeb:
            return .requestPlain
        case .pay(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
    var authorizationType: AuthorizationType? { .custom("JWT") }
}
