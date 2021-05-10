//
//  LoginViewController.swift
//  Gas
//
//  Created by Strong on 5/8/21.
//

import UIKit

class LoginViewController: BaseViewController, LoginViewInput {
    
    var output: LoginViewOutput?
    
    private let emailTextField = LabeledTextField(title: Text.phoneNumberOrEmail)
    private let passwordTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.title = Text.password
        textField.isSecureTextEntry = true
        let rightView = UIButton()
        rightView.setImage(Asset.iconEyeClosed.image, for: .normal)
        rightView.addTarget(self, action: #selector(didTapRightView(_:)), for: .touchUpInside)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let loginButton = Button.makePrimary(title: Text.enter)
    private let forgotPasswordButton = Button.makeSecondary(title: Text.forgotPassword)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        addTitleAndSubtitleLabels(title: Text.enter, subtitle: Text.enterLoginAndPasswordToLogin)
        
        setupViews()
        addHandlers()
    }
    
    private func setupViews() {
        [emailTextField, passwordTextField, loginButton, forgotPasswordButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        loginButton.setDisabled()
        view.addInputAccessoryForViews([emailTextField, passwordTextField])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: LayoutGuidance.offset),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset),
            loginButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            forgotPasswordButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -LayoutGuidance.offset),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
        ])
    }
    
    private func addHandlers() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        [emailTextField, passwordTextField].forEach { $0.maskedDelegate = self }
    }
    
    @objc
    private func didTapLogin() {
        let email = emailTextField.publicRealString
        let password = passwordTextField.publicRealString
        output?.didTapLogin(email: email, password: password)
    }
    
    @objc
    private func didTapForgotPassword() {
        output?.didTapForgotPassword()
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
        default:
            break
        }
    }
}

extension LoginViewController: MaskedTextFieldDelegate {
    func textFieldDidEndEditing(_ textField: MaskedTextfield, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case emailTextField, passwordTextField:
            if !emailTextField.publicRealString.isEmpty && !passwordTextField.publicRealString.isEmpty {
                loginButton.setEnabled()
            } else {
                loginButton.setDisabled()
            }
        default:
            break
        }
    }
}
