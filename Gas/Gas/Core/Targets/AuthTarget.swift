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
    case login(phoneNumber: String, password: String)
    case resetPassword(data: AccessRecoveryDataModel)
    
    var baseURL: URL {
        return URL(string: AppConfigs.baseUrl)!
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
        case .login:
            return "auth/"
        case .resetPassword:
            return "auth/reset_password"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accountNumber:
            return .get
        case .smsInit, .login, .register, .emailInit, .verify, .resetPassword:
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
        case .login(let phoneNumber, let password):
            return .requestParameters(parameters: ["mobile_phone": phoneNumber, "password": password], encoding: JSONEncoding.default)
        case .resetPassword(let data):
            return .requestParameters(parameters: data.toDict(), encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
}
