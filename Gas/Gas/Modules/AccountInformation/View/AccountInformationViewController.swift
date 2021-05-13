//
//  AccountInformationViewController.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import UIKit

class AccountInformationViewController: UIViewController, AccountInformationViewInput {
    
    var output: AccountInformationViewOutput?
    
    private let titleLabel = UILabel().with(font: .systemFont(ofSize: 18, weight: .semibold)).with(textColor: Color.darkGray).with(text: "Информация")
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    private let nameAccountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = LayoutGuidance.offsetAndHalf
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let cityAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = LayoutGuidance.offsetAndHalf
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let nameView = AccountInfoKeyValueView(title: "Собственник:")
    private let accountView = AccountInfoKeyValueView(title: "Номер лиц. счета:")
    private let cityView = AccountInfoKeyValueView(title: "\(Text.city):")
    private let addressView = AccountInfoKeyValueView(title: "\(Text.address):")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        output?.didLoad()
    }
    
    private func setupViews() {
        [titleLabel, verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [nameAccountStackView, cityAddressStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.addArrangedSubview($0)
        }
        
        [nameView, accountView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            nameAccountStackView.addArrangedSubview($0)
        }
        
        [cityView, addressView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cityAddressStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func display(adapter: AccountInformationDataModel) {
        nameView.setValue(adapter.full_name)
        accountView.setValue(adapter.number)
        cityView.setValue(adapter.city)
        addressView.setValue(adapter.address)
    }
}
