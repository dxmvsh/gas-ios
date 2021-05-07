//
//  AddEmailViewController.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import UIKit

class AddEmailViewController: BaseViewController, AddEmailViewInput {
    
    private let emailTextField = LabeledTextField()
    
    private let continueButton = Button.makePrimary(title: Text.getCode)
    
    var output: AddEmailViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        addTitleAndSubtitleLabels(title: Text.userRegistration,
                                  subtitle: Text.pleaseEnterEmail)
        
        emailTextField.title = Text.email
        emailTextField.keyboardType = .emailAddress
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        setupViews()
    }
    
    private func setupViews() {
        [emailTextField, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        view.addInputAccessoryForViews([emailTextField])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offsetDouble),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetDouble),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetDouble),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            continueButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset)
        ])
    }
    
    @objc
    private func didTapContinue() {
        output?.didTapSubmit(with: emailTextField.publicRealString)
    }
    
}
