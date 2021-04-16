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
    func moveToPhoneConfirmation()
    func moveToAddEmail()
    func moveToEmailConfirmation()
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
        
    }
    
    func moveToPhoneConfirmation() {
        
    }
    
    func moveToAddEmail() {
        
    }
    
    func moveToEmailConfirmation() {
        
    }
    
    func moveToOfferInfo() {
        
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
