//
//  PaymentFilterDateSelectionView.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

enum PaymentFilterDateSelectionViewComponent {
    case from
    case to
}

class PaymentFilterDateSelectionView: UIView {
    
    private let fromComponent = PaymentFilterDateSelectionComponentView()
    private let toComponent = PaymentFilterDateSelectionComponentView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var didSelect: ((PaymentFilterDateSelectionViewComponent) -> Void)?
    
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
        
        [fromComponent, toComponent].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        fromComponent.tapHandler = { [weak self] in
            self?.didTap(component: .from)
        }
        toComponent.tapHandler = { [weak self] in
            self?.didTap(component: .to)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func set(isSelected: Bool, component: PaymentFilterDateSelectionViewComponent) {
        switch component {
        case .from:
            if isSelected {
                fromComponent.setSelectedStyle()
                didTap(component: .from)
            } else {
                fromComponent.setDefaultStyle()
            }
        case .to:
            if isSelected {
                toComponent.setSelectedStyle()
                didTap(component: .to)
            } else {
                toComponent.setDefaultStyle()
            }
        }
    }
    
    func setTitle(_ text: String, for component: PaymentFilterDateSelectionViewComponent) {
        switch component {
        case .from:
            fromComponent.setTitle(text)
        case .to:
            toComponent.setTitle(text)
        }
    }
    
    func didTap(component: PaymentFilterDateSelectionViewComponent) {
        switch component {
        case .from:
            fromComponent.setSelectedStyle()
            toComponent.setDefaultStyle()
        case .to:
            toComponent.setSelectedStyle()
            fromComponent.setDefaultStyle()
        }
        didSelect?(component)
    }
    
}
