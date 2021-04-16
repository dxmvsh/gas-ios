//
//  AddPersonalAccountViewController.swift
//  Gas
//
//  Created by Strong on 4/7/21.
//

import UIKit
import SnapKit

class AddPersonalAccountViewController: BaseViewController, AddPersonalAccountViewInput {
    
    private let titleLabel = LabelFactory.buildTitleLabel()
                                         .with(text: Text.welcome)
    
    private let subtitleLabel = LabelFactory.buildSubtitleLabel()
                                            .with(text: Text.pleaseEnterFieldCorrectly)
                                            .with(numberOfLines: 0)
    
    private let accountNumberTextField = LabeledTextField(title: Text.personalAccountNumber,
                                             prefix: "",
                                             suffix: "",
                                             formatPattern: "",
                                             placeholderChar: "",
                                             allowedSymbolsRegex: RegexConstants.allowedSymbolsForNumberRegex,
                                             editingActions: [.copy, .paste])
    
    private let continueButton = Button.makePrimary(title: Text.continue)
    
    var output: AddPersonalAccountViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        setupViews()
        
        accountNumberTextField.maskedDelegate = self
        accountNumberTextField.keyboardType = .numberPad
        view.addInputAccessoryForViews([accountNumberTextField])
        
        continueButton.setDisabled()
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        [titleLabel, subtitleLabel, accountNumberTextField, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [titleLabel, subtitleLabel].forEach {
            $0.textAlignment = .center
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGuidance.offsetDouble),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            accountNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetAndHalf),
            accountNumberTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offsetDouble),
            accountNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetAndHalf),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset),
            continueButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight)
        ])
    }
    
    @objc
    private func continueTapped() {
        let number = accountNumberTextField.publicRealString
        output?.didTapSubmit(accountNumber: number)
    }
}

extension AddPersonalAccountViewController: MaskedTextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: MaskedTextfield, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case accountNumberTextField:
            if !accountNumberTextField.publicRealString.isEmpty {
                continueButton.setEnabled()
            } else {
                continueButton.setDisabled()
            }
        default:
            break
        }
    }
    
}
