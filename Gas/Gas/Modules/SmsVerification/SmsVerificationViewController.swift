//
//  SmsVerificationViewController.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

class SmsVerificationViewController: BaseViewController, SmsVerificationViewInput {
    
    private let smsCodeTextField = SmsCodeTextField()
    
    var output: SmsVerificationViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        addTitleAndSubtitleLabels(title: Text.enterCode, subtitle: Text.weSendYouSms)
        
        configureTextField()
        
        setupViews()
        
        output?.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        smsCodeTextField.becomeFirstResponder()
    }
    
    private func configureTextField() {
        smsCodeTextField.keyboardType = .numberPad
        smsCodeTextField.didEnterCode = { [weak self] code in
            self?.output?.didEnterCode(code)
        }
    }
    
    private func setupViews() {
        [smsCodeTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            smsCodeTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            smsCodeTextField.heightAnchor.constraint(equalToConstant: 50),
            smsCodeTextField.widthAnchor.constraint(equalToConstant: 180),
            smsCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setErrorStyle(message: String) {
        smsCodeTextField.showError(message: message)
    }
    
    func setTitleAndSubtitleTexts(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}
