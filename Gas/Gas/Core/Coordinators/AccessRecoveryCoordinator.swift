//
//  AccessRecoveryCoordinator.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol AccessRecoveryCoordinatorProtocol {
    func start()
    func moveToAddEmail()
    func moveToEmailVerification(email: String)
    func moveToSetPassword(email: String)
    func moveToSetPasscode()
    func moveToSetBiometry()
    func moveToMainPage()
}

class AccessRecoveryCoordinator: AccessRecoveryCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        moveToAddEmail()
    }
    
    func moveToAddEmail() {
        let viewController = AddEmailAssembly().assemble(self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToEmailVerification(email: String) {
        let viewController = SmsVerificationAssembly().assembleEmail(self, email: email)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToSetPassword(email: String) {
        let viewController = PasswordAssembly().assemble(mode: .recover) { [weak self] input -> PasswordModuleOutput? in
            input.configure(accessRecoveryDataModel: AccessRecoveryDataModel(email: email))
            return self
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToSetPasscode() {
        let viewController = PasscodeAssembly().assemble(mode: .set, self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToSetBiometry() {
        let viewController = BiometryAssembly().assemble(self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToMainPage() {
        // TODO: add main page
    }
}

extension AccessRecoveryCoordinator: AddEmailModuleOutput, EmailVerificationModuleOutput, PasswordModuleOutput, PasscodeModuleOutput, BiometryModuleOutput {
    func didAdd(email: String) {
        moveToEmailVerification(email: email)
    }
    
    func didSucceedEmailVerification(email: String) {
        moveToSetPassword(email: email)
    }
    
    func didFailEmailVerification() {
        
    }
    
    func didSucceedPasswordSet() {
        moveToSetPasscode()
    }
    
    func didFailPasswordSet() {
        
    }
    
    func didSucceedPasscodeModule() {
        moveToSetBiometry()
    }
    
    func didFailPasscodeModule() {
        
    }
    
    func didSucceedBiometry() {
        moveToMainPage()
    }
    
    func didFailBiometry() {
        
    }
}
