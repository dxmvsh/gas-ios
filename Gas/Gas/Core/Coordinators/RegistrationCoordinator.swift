//
//  RegistrationCoordinator.swift
//  Gas
//
//  Created by Strong on 4/7/21.
//

import UIKit

protocol RegistrationCoordinator {
    func start()
    func moveToPersonalAccount()
    func moveToUserData(accountNumber: String)
    func moveToAddPhone()
    func moveToPhoneConfirmation(phoneNumber: String)
    func moveToAddEmail()
    func moveToEmailConfirmation(email: String)
    func moveToOfferInfo()
    func moveToSetPassword()
    func moveToSetPasscode()
    func moveToResultPage()
}

class RegistrationCoordinatorManager: RegistrationCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        moveToPersonalAccount()
    }
    
    func moveToPersonalAccount() {
        let viewController = AddPersonalAccountAssembly().assemble(self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToUserData(accountNumber: String) {
        let viewController = UserInformationAssembly().assemble { [weak self] input in
            input.setAccountNumber(accountNumber)
            return self
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToAddPhone() {
        let viewController = AddPhoneAssembly().assemble(self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToPhoneConfirmation(phoneNumber: String) {
        let viewController = SmsVerificationAssembly().assemblePhone(self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToAddEmail() {
        let viewController = AddEmailAssembly().assemble(self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToEmailConfirmation(email: String) {
        let viewController = SmsVerificationAssembly().assembleEmail(self, email: email)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToOfferInfo() {
        let viewController = OfferInformationViewController()
        viewController.completion = {
            self.moveToSetPassword()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToSetPassword() {
        
    }
    
    func moveToSetPasscode() {
        
    }
    
    func moveToResultPage() {
        
    }
}

extension RegistrationCoordinatorManager: AddPersonalAccountModuleOutput {
    func didTapSubmit(accountNumber: String) {
        moveToUserData(accountNumber: accountNumber)
    }
}

extension RegistrationCoordinatorManager: UserInformationModuleOutput {
    func didTapSubmit(_ userInfo: UserInformationDataModel) {
        moveToAddPhone()
    }
}

extension RegistrationCoordinatorManager: AddPhoneModuleOutput {
    func didFinish(with phoneNumber: String) {
        moveToPhoneConfirmation(phoneNumber: phoneNumber)
    }
}

extension RegistrationCoordinatorManager: SmsVerificationModuleOutput {
    func didSucceed() {
        moveToAddEmail()
    }
    
    func didFail() {
        
    }
}

extension RegistrationCoordinatorManager: AddEmailModuleOutput {
    func didAdd(email: String) {
        moveToEmailConfirmation(email: email)
    }
}

extension RegistrationCoordinatorManager: EmailVerificationModuleOutput {
    func didSucceedEmailVerification() {
        moveToOfferInfo()
    }
    
    func didFailEmailVerification() {
        
    }
}
