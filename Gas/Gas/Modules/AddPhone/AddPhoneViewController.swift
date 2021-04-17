//
//  AddPhoneViewController.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

class AddPhoneViewController: BaseViewController, AddPhoneViewInput {
    
    private let phoneNumberTextField = MaskedTextfield(prefix: "+7 (", suffix: "", formatPattern: "###) ###-##-##", placeholderChar: "X")
    
    private let continueButton = Button.makePrimary(title: Text.getCode)
    
    var output: AddPhoneViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        addTitleAndSubtitleLabels(title: Text.userRegistration,
                                  subtitle: Text.enterPhoneNumberToRegister)
        
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        setupViews()
    }
    
    private func setupViews() {
        [phoneNumberTextField, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        view.addInputAccessoryForViews([phoneNumberTextField])
        
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offsetDouble),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetDouble),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetDouble),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            continueButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset)
        ])
    }
    
    @objc
    private func didTapContinue() {
        output?.didTapSubmit(with: phoneNumberTextField.publicRealString.onlyDigits)
    }
    
}
