//
//  AuthTarget.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Moya

enum AuthTarget: TargetType {
    
    case accountNumber(number: String)
    case smsInit(phoneNumber: String)
    case verify(code: String)
    case emailInit(email: String)
    case register(user: UserDataModel)
    
    var baseURL: URL {
        return URL(string: "http://130.61.58.200/api/")!
    }
    
    var path: String {
        switch self {
        case .accountNumber(let number):
            return "auth/account_number/\(number)"
        case .smsInit:
            return "auth/otp/send/"
        case .verify:
            return "auth/otp/verify/"
        case .emailInit:
            return "auth/otp/email/"
        case .register:
            return "auth/registration/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accountNumber:
            return .get
        case .smsInit:
            return .post
        case .verify:
            return .post
        case .emailInit:
            return .post
        case .register:
            return .post
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .accountNumber:
            return .requestPlain
        case .smsInit(let phoneNumber):
            return .requestParameters(parameters: ["mobile_phone": phoneNumber], encoding: JSONEncoding.default)
        case .emailInit(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .register(let user):
            return .requestParameters(parameters: user.toDict(), encoding: JSONEncoding.default)
        case .verify(let code):
            return .requestParameters(parameters: ["otp_code": code], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
}
