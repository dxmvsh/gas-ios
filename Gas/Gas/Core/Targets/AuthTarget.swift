//
//  AuthTarget.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Moya

enum AuthTarget: TargetType {
    
    case accountNumber(number: String)
    case smsInit(phoneToken: PhoneAuthTokenSend)
    case verify(code: String)
    
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
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .accountNumber:
            return .requestPlain
        case .smsInit(let phoneToken):
            return .requestParameters(parameters: ["mobile_phone": phoneToken.mobile_phone], encoding: JSONEncoding.default)
        case .verify(let code):
            return .requestParameters(parameters: ["otp_code": code], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
}
