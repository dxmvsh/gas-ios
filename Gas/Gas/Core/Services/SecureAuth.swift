//
//  SecureAuth.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation
import LocalAuthentication
import KeychainSwift

protocol SecureAuthenticationProtocol {
    var canSetBiometry: Bool { get }
    var isPasscodeSet: Bool { get }
    func authenticateWithPasscode(_ passcode: String, completion: @escaping ((_ success: Bool) -> Void))
    func authenticateWithBio(completion: @escaping ((_ success: Bool) -> Void))
    func setPasscode(_ code: String)
    func setEmail(_ email: String)
    func setPassword(_ password: String)
    func setBiometry()
    func setToken(_ token: String)
}

fileprivate enum Constants {
    static let passcodeKey: String = "Passcode"
    static let passwordKey: String = "Password"
    static let emailKey: String = "Email"
    static let biometryEnabledKey: String = "IsBiometryEnabled"
    static let tokenKey: String = "token"
}

class SecureAuthentication: SecureAuthenticationProtocol {
    
    var canSetBiometry: Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    var isPasscodeSet: Bool {
        return keychain.get(Constants.passcodeKey) != nil
    }
    
    let context = LAContext()
    let keychain = KeychainSwift()
    var error: NSError?
    private let dataProvider: AuthorizationServiceProtocol
    
    init(dataProvider: AuthorizationServiceProtocol) {
        self.dataProvider = dataProvider
    }
    
    func authenticateWithBio(completion: @escaping ((_ success: Bool) -> Void)) {
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            completion(false)
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in to your account") { [unowned self] (success, error) in
            if success {
                if let passcode = self.keychain.get(Constants.passcodeKey) {
                    self.authenticateWithPasscode(passcode, completion: completion)
                }
            } else {
                
            }
        }
    }
    
    func authenticateWithPasscode(_ passcode: String, completion: @escaping ((_ success: Bool) -> Void)) {
        guard let passcodeSaved = keychain.get(Constants.passcodeKey) else { return }
        if passcode == passcodeSaved {
            if let password = keychain.get(Constants.passwordKey),
               let email = keychain.get(Constants.emailKey) {
                dataProvider.login(phoneNumber: email, password: password) { [weak self] result in
                    switch result {
                    case .success(let message):
                        self?.setToken(message.refresh)
                        completion(true)
                    case .failure(let error):
                        completion(false)
                    }
                }
            }
        } else {
            completion(false)
        }
    }
    
    func setPasscode(_ code: String) {
        if keychain.get(Constants.passcodeKey) != nil {
            keychain.delete(Constants.passcodeKey)
        }
        keychain.set(code, forKey: Constants.passcodeKey)
    }
    
    func setEmail(_ email: String) {
        if keychain.get(Constants.emailKey) != nil {
            keychain.delete(Constants.emailKey)
        }
        keychain.set(email, forKey: Constants.emailKey)
    }
    
    func setPassword(_ password: String) {
        if keychain.get(Constants.passwordKey) != nil {
            keychain.delete(Constants.passwordKey)
        }
        keychain.set(password, forKey: Constants.passwordKey)
    }
    
    func setBiometry() {
        keychain.set(true, forKey: Constants.biometryEnabledKey)
    }
    
    func setToken(_ token: String) {
        keychain.set(token, forKey: Constants.tokenKey)
    }
}
