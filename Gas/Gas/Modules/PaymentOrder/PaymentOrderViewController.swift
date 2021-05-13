//
//  PaymentOrderViewController.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

class PaymentOrderViewController: BaseViewController, PaymentOrderViewInput {
    
    var output: PaymentOrderViewOutput?
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.isScrollEnabled = true
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offsetDouble
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let accountInfoView = PaymentOrderAccountInfoView()
    private let counterInfoView = PaymentOrderCounterInfoView()
    private let button = Button.makePaymentButton(leftTitle: "Итого: 0 ₸", rightTitle: "К оплате")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        title = "Показатели"
        view.backgroundColor = Color.backgroundColor
        button.setDisabled()
        button.addTarget(self, action: #selector(didTapPay), for: .touchUpInside)
        output?.didLoad()
        setupViews()
    }
    
    private func setupViews() {
        [scrollView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [accountInfoView, counterInfoView, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        counterInfoView.didEnterIndicator = { [weak self] indicator in
            self?.output?.didSetIndicator(indicator)
        }
        
        counterInfoView.didClearIndicator = { [weak self] in
            self?.button.setLeftTitle("Итого: 0 ₸")
            self?.button.setDisabled()
        }
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: LayoutGuidance.offset),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -LayoutGuidance.offset),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: LayoutGuidance.offset),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -LayoutGuidance.offset),
            stackView.widthAnchor.constraint(equalToConstant: DeviceConstants.screenWidth - LayoutGuidance.offsetDouble)
        ])
    }
    
    func display(account: AccountInformationDataModel) {
        accountInfoView.setAdapter(account)
    }
    
    func display(calculation: CalculationDataModel) {
        counterInfoView.setUsed("\(calculation.used) \(UnitVolume.cubicMeters.symbol)")
        counterInfoView.setCalculatedState()
        button.setLeftTitle("Итого: \(calculation.amount) ₸")
        button.setEnabled()
    }
    
    func set(lastIndicator: String) {
        counterInfoView.setLastIndicator("\(lastIndicator) \(UnitVolume.cubicMeters.symbol)")
    }
    
    @objc
    private func didTapPay() {
        output?.didTapPay()
    }
    
}
