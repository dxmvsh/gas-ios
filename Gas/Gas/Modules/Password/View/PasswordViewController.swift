//
//  PasswordViewController.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

class PasswordViewController: BaseViewController, PasswordViewInput {
    
    private let passwordTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.title = Text.createPassword
        textField.isSecureTextEntry = true
        let rightView = UIButton()
        rightView.setImage(Asset.iconEyeClosed.image, for: .normal)
        rightView.addTarget(self, action: #selector(didTapRightView(_:)), for: .touchUpInside)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let confirmPasswordTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.title = Text.confirmPassword
        textField.isSecureTextEntry = true
        let rightView = UIButton()
        rightView.setImage(Asset.iconEyeClosed.image, for: .normal)
        rightView.addTarget(self, action: #selector(didTapRightView(_:)), for: .touchUpInside)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offset
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let passwordRulesView = PasswordRulesView()
    private let continueButton = Button.makePrimary(title: Text.continue)
    
    var output: PasswordViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        addTitleAndSubtitleLabels(title: Text.userRegistration, subtitle: Text.createPasswordForLogin)
        
        setupViews()
        
        output?.didLoad()
    }
    
    private func setupViews() {
        [passwordTextField, confirmPasswordTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        [stackView, passwordRulesView, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        passwordTextField.maskedDelegate = self
        confirmPasswordTextField.maskedDelegate = self
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        continueButton.setDisabled()
        view.addInputAccessoryForViews([passwordTextField, confirmPasswordTextField])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            passwordRulesView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGuidance.offsetDouble),
            passwordRulesView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordRulesView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset),
            continueButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
        ])
    }
    
    func setPasswordRules(_ rules: [PasswordRuleViewAdapter]) {
        passwordRulesView.setAdapters(rules)
    }
    
    func setRulesHighlighted(_ highlighted: [Bool]) {
        for (index, value) in highlighted.enumerated() {
            passwordRulesView.setLabel(isHighlighted: value, at: index)
        }
    }
    
    func setButton(active: Bool) {
        if active {
            continueButton.setEnabled()
        } else {
            continueButton.setDisabled()
        }
    }
    
    func showConfirmPasswordError(_ message: String) {
        confirmPasswordTextField.showViewError(message)
    }
    
    @objc
    private func didTapContinue() {
        output?.didTapContinue()
    }
    
    @objc
    private func didTapRightView(_ button: UIButton) {
        switch button {
        case passwordTextField.rightView:
            if passwordTextField.isSecureTextEntry {
                button.setImage(Asset.iconEyeOpen.image, for: .normal)
            } else {
                button.setImage(Asset.iconEyeClosed.image, for: .normal)
            }
            passwordTextField.isSecureTextEntry.toggle()
        case confirmPasswordTextField.rightView:
            if confirmPasswordTextField.isSecureTextEntry {
                button.setImage(Asset.iconEyeOpen.image, for: .normal)
            } else {
                button.setImage(Asset.iconEyeClosed.image, for: .normal)
            }
            confirmPasswordTextField.isSecureTextEntry.toggle()
        default:
            break
        }
    }
    
}

extension PasswordViewController: MaskedTextFieldDelegate {
    
    func textFieldDidChange(_ textField: MaskedTextfield) {
        switch textField {
        case passwordTextField:
            let password = textField.publicRealString
            output?.didChangePassword(password)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: MaskedTextfield, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case passwordTextField:
            let password = textField.publicRealString
            output?.didSetPassword(password)
        case confirmPasswordTextField:
            let password = textField.publicRealString
            output?.didSetConfirmPassword(password)
        default:
            break
        }
    }
    
}
