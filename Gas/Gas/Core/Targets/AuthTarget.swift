//
//  AuthTarget.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Moya

enum AuthTarget: TargetType {
    
    case accountNumber(number: String)
    
    var baseURL: URL {
        return URL(string: "http://130.61.58.200/api/")!
    }
    
    var path: String {
        switch self {
        case .accountNumber(let number):
            return "auth/account_number/\(number)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accountNumber:
            return .get
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .accountNumber:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
    
}
