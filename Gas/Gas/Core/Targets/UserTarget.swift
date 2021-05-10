//
//  UserTarget.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import Moya

enum UserTarget: TargetType, AccessTokenAuthorizable {
    
    case analytics
    case info
    
    var baseURL: URL {
        return URL(string: AppConfigs.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .analytics:
            return "users/analytics/"
        case .info:
            return "users/info/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .analytics, .info:
            return .get
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .analytics, .info:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
    
    var authorizationType: AuthorizationType? { .custom("JWT") }
    
}
