//
//  ApiError.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation
import Moya

struct ApiError: Error, Codable {
    enum Code: String, Codable, CaseIterable {
        case argumentMissing = "argument_missing"
        case tokenExpired = "token_expired"
        case internalServerError = "internal_server_error"
        case invalidSignature = "invalid_signature"
        case invalidCode = "invalid_code"
        case resourceBlocked = "resource_blocked"
        case resourceNotFound = "resource_not_found"
        case invalidPhoneFormat = "invalid_phone_format"
        case deviceTokenInvalid = "device_token_invalid"
        case invalidData = "invalid_data"
        case userBlocked = "user_blocked"
        case identicalPasswords = "identical_passwords"
        case badRequest = "bad_request"
        case forbidden = "forbidden"
        case rateChanged = "rate_changed"
        case authorizationError = "authorization_error"
        case noCode = ""
    }

    enum CodingKeys: String, CodingKey {
        case code
        case description
        case data
        case errorDescription = "error_description"
    }
    
    var code: Code
    var description: String?
    var httpStatusCode: Int? = 500
    var data: [String: Any]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeValue = try container.decode(String.self, forKey: .code)
        code = Converter.makeApiErrorCode(string: codeValue)
        if let desc = try? container.decode(String.self, forKey: .description) {
            description = desc
        } else if let errorDesc = try? container.decode(String.self, forKey: .errorDescription) {
            description = errorDesc
        }
        data = try? container.decode([String: Any].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code.rawValue, forKey: .code)
        try container.encode(description, forKey: .description)
        if let data = data {
            try container.encode(data, forKey: .data)
        }
    }

    static func build(response: Response?) -> ApiError? {
        guard let response = response else { return nil }
        do {
            var result = try response.map(ApiError.self)
            result.httpStatusCode = response.statusCode
            return result
        } catch {
            
        }
        return nil
    }
    
    func getErrorText() -> String {
        let text = self.description ?? ""
        
        if let data = self.data as? [String: String] {
            return Array(data.values).joined(separator: "\n")
        }

        return text
    }
}
