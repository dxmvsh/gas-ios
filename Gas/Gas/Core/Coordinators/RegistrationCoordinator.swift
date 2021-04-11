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
    func moveToUserData()
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
        let viewController = AddPersonalAccountViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToUserData() {
        
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
