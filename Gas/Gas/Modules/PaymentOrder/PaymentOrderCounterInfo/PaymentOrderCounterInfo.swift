//
//  PaymentOrderCounterInfo.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

class PaymentOrderCounterInfoView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    private let counterTextField = CounterTextField(count: 4, placeholderCharacter: "0")
    
    private let currentCountTextField = LabeledTextField(title: "Текущий показатель")
    private let previousTextField = LabeledTextField(title: "Предыдущий показатель")
    private let usedCountTextField = LabeledTextField(title: "Потребление")
    
    private var defaultStateTextFields: [UITextField] {
        return [counterTextField]
    }
    
    private var calculatedStateTextFields: [UITextField] {
        return [currentCountTextField, previousTextField, usedCountTextField]
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        previousTextField.isUserInteractionEnabled = false
        usedCountTextField.isUserInteractionEnabled = false
        
        calculatedStateTextFields.forEach {
            $0.isHidden = true
        }
        
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setAdapter(_ adapter: PaymentOrderCounterInfoAdapter) {
        
    }
}
