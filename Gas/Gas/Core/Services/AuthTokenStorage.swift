//
//  AuthTokenStorage.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import Foundation

protocol AuthTokenStorageProtocol {
    static var shared: AuthTokenStorageProtocol { get }
    func getToken() -> String
}

class AuthTokenStorage: AuthTokenStorageProtocol {
    
    static let shared: AuthTokenStorageProtocol = AuthTokenStorage()
    private let secureAuth = SecureAuthentication(dataProvider: AuthorizationService())
    
    private init() {}
    
    func getToken() -> String { secureAuth.getToken() }
    
}
