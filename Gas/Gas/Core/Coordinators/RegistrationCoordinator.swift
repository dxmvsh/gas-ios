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
    func moveToSetBiometry()
    func moveToResultPage()
}

class RegistrationCoordinatorManager: RegistrationCoordinator {
    
    let navigationController: UINavigationController
    var phoneNumber: String?
    var email: String?
    var accountNumber: String?
    private let secureAuth: SecureAuthenticationProtocol
    init(navigationController: UINavigationController,
         secureAuth: SecureAuthenticationProtocol) {
        self.navigationController = navigationController
        self.secureAuth = secureAuth
    }
    
    func start() {
        moveToResultPage()
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
        let viewController = SmsVerificationAssembly().assemblePhone(self, phoneNumber: phoneNumber)
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
        let viewController = PasswordAssembly().assemble(mode: .set) { [weak self] input -> PasswordModuleOutput? in
            if let phoneNumber = self?.phoneNumber,
               let email = self?.email,
               let accountNumber = self?.accountNumber {
                input.configure(userDataModel: UserDataModel(mobile_phone: "+\(phoneNumber)", email: email, account_number: accountNumber, password: ""))
            }
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
    
    func moveToResultPage() {
        let viewController = ResultViewController()
        viewController.setSuccessState()
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                viewController.dismiss(animated: true)
                self?.navigationController.popToRootViewController(animated: true)
            }
        }
    }
}

extension RegistrationCoordinatorManager: AddPersonalAccountModuleOutput {
    func didTapSubmit(accountNumber: String) {
        moveToUserData(accountNumber: accountNumber)
    }
}

extension RegistrationCoordinatorManager: UserInformationModuleOutput {
    func didTapContinue(accountNumber: String) {
        self.accountNumber = accountNumber
        moveToAddPhone()
    }
}

extension RegistrationCoordinatorManager: AddPhoneModuleOutput {
    func didFinish(with phoneNumber: String) {
        moveToPhoneConfirmation(phoneNumber: phoneNumber)
    }
}

extension RegistrationCoordinatorManager: SmsVerificationModuleOutput {
    func didSucceed(phoneNumber: String) {
        self.phoneNumber = phoneNumber
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
    func didSucceedEmailVerification(email: String) {
        self.email = email
        moveToOfferInfo()
    }
    
    func didFailEmailVerification() {
        
    }
}

extension RegistrationCoordinatorManager: PasswordModuleOutput {
    
    func didSucceedPasswordSet() {
        moveToSetPasscode()
    }
    
    func didFailPasswordSet() {
        
    }
    
}

extension RegistrationCoordinatorManager: PasscodeModuleOutput {
    
    func didSucceedPasscodeModule() {
        if secureAuth.canSetBiometry {
            moveToSetBiometry()
        } else {
            moveToResultPage()
        }
    }
    
    func didFailPasscodeModule() {
        
    }
    
}

extension RegistrationCoordinatorManager: BiometryModuleOutput {
    func didSucceedBiometry() {
        moveToResultPage()
    }
    
    func didFailBiometry() {
        moveToResultPage()
    }
}
