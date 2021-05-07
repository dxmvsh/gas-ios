//
//  UserInformationViewController.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

class UserInformationViewController: BaseViewController, UserInformationViewInput {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    private let fullnameTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.title = Text.fio
        return textField
    }()
    
    private let accountNumberTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.title = Text.personalAccountNumber
        return textField
    }()
    
    private let cityTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.title = Text.city
        return textField
    }()
    
    private let addressTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.title = Text.address
        return textField
    }()
    
    private let continueButton = Button.makePrimary(title: Text.continue)
    
    var output: UserInformationViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        addTitleAndSubtitleLabels(title: Text.userRegistration, subtitle: Text.checkDataToContinue)
        setupViews()
        
        continueButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        
        output?.didLoad()
    }
    
    private func setupViews() {
        [stackView, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        view.addInputAccessoryForViews([fullnameTextField, accountNumberTextField, cityTextField, addressTextField])
        [fullnameTextField, accountNumberTextField, cityTextField, addressTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset),
            continueButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight)
        ])
    }
    
    func display(_ userInfo: UserInformationDataModel) {
        fullnameTextField.setText(userInfo.full_name)
        accountNumberTextField.setText(userInfo.number)
        cityTextField.setText(userInfo.city)
        addressTextField.setText(userInfo.address)
    }
    
    @objc
    private func didTapSubmit() {
        output?.didTapSubmit()
    }
}
