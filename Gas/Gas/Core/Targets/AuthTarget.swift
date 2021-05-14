//
//  AuthTarget.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Moya

enum AuthTarget: TargetType, AccessTokenAuthorizable {
    
    case accountNumber(number: String)
    case smsInit(phoneNumber: String)
    case verify(code: String)
    case emailInit(email: String)
    case register(user: UserDataModel)
    case login(phoneNumber: String, password: String)
    case resetPassword(data: AccessRecoveryDataModel)
    case changeNumber(phoneNumber: String, code: String)
    case changeEmail(email: String, code: String)
    case changePassword(oldPassword: String, newPassword: String, confirmedPassword: String)
    
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
        case .changeNumber:
            return "users/profile/change_number"
        case .changeEmail:
            return "users/profile/change_email"
        case .changePassword:
            return "users/settings/password/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accountNumber:
            return .get
        case .smsInit, .login, .register, .emailInit, .verify, .resetPassword, .changeNumber, .changeEmail:
            return .post
        case .changePassword:
            return .put
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
        case .changeNumber(let phoneNumber, let code):
            return .requestParameters(parameters: ["mobile_phone": phoneNumber, "otp_code": code], encoding: JSONEncoding.default)
        case .changeEmail(let email, let code):
            return .requestParameters(parameters: ["email": email, "otp_code": code], encoding: JSONEncoding.default)
        case .changePassword(let old, let new, let conf):
            return .requestParameters(parameters: ["old_password": old, "password": new, "confirmed_password": conf], encoding: JSONEncoding.default)
        }
    }
    
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .changeEmail, .changeNumber, .changePassword:
            return .custom("JWT")
        default:
            return nil
        }
    }
    
    var headers: [String : String]? { nil }
    
}
