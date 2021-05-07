//
//  QueryEncoding.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation
import Alamofire

struct QueryEncoding: ParameterEncoding {
    
    public static var `default`: QueryEncoding { return QueryEncoding() }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        guard let parameters = parameters else { return request }
        guard let url = request.url else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
            urlComponents.query = percentEncodedQuery
            request.url = urlComponents.url
        }
        return request
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dict = value as? [String: Any] {
            let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed)
            let str = String(data: data!, encoding: .utf8)!
            components.append((key, str))
        } else if let list = value as? [String] {
            let str = list.joined(separator: ",")
            components.append((key, str))
        } else {
            components.append((key, "\(value)"))
        }
        return components
    }
}
