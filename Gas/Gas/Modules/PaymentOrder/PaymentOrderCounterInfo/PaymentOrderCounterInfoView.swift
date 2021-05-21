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
        stackView.spacing = LayoutGuidance.offsetThreeQuarter
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleLabel = UILabel().with(text: "Газ, Счетчик").with(textColor: Color.darkGray).with(font: .systemFont(ofSize: 16, weight: .regular))
    
    private let counterTextField = CounterTextField(count: 4, placeholderCharacter: "0")
    
    private let currentCountView = AccountInfoKeyValueView(title: "Текущий показатель", value: "", hasBottomLine: true, hasClearIconView: true)
    private let previousView = AccountInfoKeyValueView(title: "Предыдущий показатель", value: "", hasBottomLine: true)
    private let usedCountView = AccountInfoKeyValueView(title: "Потребление", value: "", hasBottomLine: true)
    
    private var defaultStateTextFields: [UITextField] {
        return [counterTextField]
    }
    
    private var calculatedStateViews: [AccountInfoKeyValueView] {
        return [currentCountView, previousView, usedCountView]
    }
    
    var didEnterIndicator: ((Int) -> Void)?
    var didClearIndicator: (() -> Void)?
    var didTapScan: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        previousView.isUserInteractionEnabled = false
        usedCountView.isUserInteractionEnabled = false
        backgroundColor = .white
        calculatedStateViews.forEach {
            $0.isHidden = true
        }
        defaultStateTextFields.forEach {
            $0.isHidden = true
        }
        defaultStateTextFields.forEach {
            $0.isHidden = false
        }
        addInputAccessoryForViews(defaultStateTextFields)
        addInputAccessoryForViews(calculatedStateViews)
        counterTextField.didEnterCode = { [weak self] indicator in
            guard let decimalIndicator = Int(indicator) else { return }
            self?.didEnterIndicator?(decimalIndicator)
            self?.currentCountView.setValue("\(decimalIndicator) \(UnitVolume.cubicMeters.symbol)")
        }
        
        counterTextField.didTapScan = { [weak self] in
            self?.didTapScan?()
        }
        
        currentCountView.didTapIconViewClosure = { [weak self] in
            self?.setDefaultState()
            self?.counterTextField.clear()
            self?.didClearIndicator?()
        }
        
        [titleLabel, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        defaultStateTextFields.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        calculatedStateViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.titleLabel.font = .systemFont(ofSize: 14, weight: .light)
            $0.valueLabel.font = .systemFont(ofSize: 16)
            stackView.addArrangedSubview($0)
        }
        
        roundCorners(radius: 12)
        stackView.roundCorners(radius: 12)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offsetAndHalf),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offset),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance
                                                .offset),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance
                                            .offset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance
                                                    .offset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGuidance
                                                .offsetDouble),
        ])
    }
    
    func setCurrentIndicator(_ indicator: String) {
        currentCountView.setValue(indicator)
    }
    
    func setUsed(_ used: String) {
        usedCountView.setValue(used)
    }
    
    func setLastIndicator(_ indicator: String) {
        previousView.setValue(indicator)
    }
    
    func setCalculatedState() {
        UIView.animate(withDuration: 0.5) {
            self.defaultStateTextFields.forEach {
                $0.isHidden = true
            }
            UIView.animate(withDuration: 0.5) {
                self.calculatedStateViews.forEach {
                    $0.isHidden = false
                }
            }
        }
    }
    
    func setDefaultState() {
        UIView.animate(withDuration: 0.5) {
            self.calculatedStateViews.forEach {
                $0.isHidden = true
            }
            UIView.animate(withDuration: 0.5) {
                self.defaultStateTextFields.forEach {
                    $0.isHidden = false
                }
            }
        }
    }
}
