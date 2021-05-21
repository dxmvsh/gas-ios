//
//  CommonTarget.swift
//  Gas
//
//  Created by Strong on 5/21/21.
//

import Moya

enum CommonTarget: TargetType, AccessTokenAuthorizable {
    
    case contactSupport(message: String)
    
    var baseURL: URL {
        return URL(string: AppConfigs.baseUrl)!
    }
    
    var path: String {
        return "common/support/"
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .contactSupport(let message):
            return .requestParameters(parameters: ["message": message], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
    var authorizationType: AuthorizationType? { return .custom("JWT") }
}
