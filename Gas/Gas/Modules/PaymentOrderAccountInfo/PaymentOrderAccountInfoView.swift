//
//  PaymentOrderAccountInfoView.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

class PaymentOrderAccountInfoView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    private let numberView = AccountInfoKeyValueView(title: "Номер лицевого счета")
    private let fullnameView = AccountInfoKeyValueView(title: "Собственник")
    private let cityView = AccountInfoKeyValueView(title: "Город")
    private let addressView = AccountInfoKeyValueView(title: "Адрес")
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        backgroundColor = .white
        [numberView, fullnameView, cityView, addressView].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        roundCorners(radius: 12)
        stackView.roundCorners(radius: 12)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance
                                                .offsetAndHalf),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance
                                            .offsetAndHalf),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance
                                                    .offsetAndHalf),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGuidance
                                                .offsetAndHalf),
        ])
    }
    
    func setAdapter(_ adapter: AccountInformationDataModel) {
        numberView.setValue(adapter.number)
        fullnameView.setValue(adapter.full_name)
        cityView.setValue(adapter.city)
        addressView.setValue(adapter.address)
    }
}
