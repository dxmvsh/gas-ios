//
//  SignInCoordinator.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol SignInCoordinatorProtocol {
    func start()
    func moveToLogin()
    func moveToEnterPasscode()
    func moveToSetPasscode()
    func moveToSetBiometry()
    func moveToMainPage()
}

class SignInCoordinator: SignInCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let secureAuth = SecureAuthentication(dataProvider: AuthorizationService())
    var accessRecoveryCoordinator: AccessRecoveryCoordinatorProtocol?
    var mainTabsCoordinator: TabBarCoordinatorProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        moveToLogin()
        if !secureAuth.getToken().isEmpty {
            moveToEnterPasscode()
        }
    }
    
    func moveToLogin() {
        let viewController = LoginAssembly().assemble(self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToEnterPasscode() {
        let viewController = PasscodeAssembly().assemble(mode: .enter, self)
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
        mainTabsCoordinator?.start(index: 0)
    }
}

extension SignInCoordinator: LoginModuleOutput, PasscodeModuleOutput, BiometryModuleOutput {
    
    func didLogin() {
        moveToSetPasscode()
    }
    
    func didTapForgotPassword() {
        accessRecoveryCoordinator?.start()
    }
    
    func didSucceedPasscodeModule() {
        if !secureAuth.getToken().isEmpty {
            moveToMainPage()
        } else {
            moveToSetBiometry()
        }
    }
    
    func didFailPasscodeModule() {
        
    }
    
    func didSucceedBiometry() {
        moveToMainPage()
    }
    
    func didFailBiometry() {
        
    }
}
