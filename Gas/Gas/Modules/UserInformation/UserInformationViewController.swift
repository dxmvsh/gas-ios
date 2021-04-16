//
//  UserInformationViewController.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

class UserInformationViewController: BaseViewController, UserInformationViewInput {
    
    private let titleLabel = LabelFactory.buildTitleLabel()
                                         .with(text: Text.userRegistration)
                                         .with(alignment: .center)
                                         .with(numberOfLines: 0)
    
    private let subtitleLabel = LabelFactory.buildSubtitleLabel()
                                            .with(text: Text.checkDataToContinue)
                                            .with(numberOfLines: 0)
                                            .with(alignment: .center)
    private let continueButton = Button.makePrimary(title: Text.continue)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = LayoutGuidance.offsetQuarter
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
    
    var output: UserInformationViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupContactSupportButton()
        
        setupViews()
        
        output?.didLoad()
    }
    
    private func setupViews() {
        [titleLabel, subtitleLabel, stackView, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        view.addInputAccessoryForViews([fullnameTextField, accountNumberTextField, cityTextField, addressTextField])
        [fullnameTextField, accountNumberTextField, cityTextField, addressTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetHalf),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGuidance.offsetDouble),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetHalf),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetHalf),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetHalf),
            
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
        fullnameTextField.setText(userInfo.fio)
        accountNumberTextField.setText(userInfo.accountNumber)
        cityTextField.setText(userInfo.city)
        addressTextField.setText(userInfo.address)
    }
}
