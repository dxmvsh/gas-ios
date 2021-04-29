//
//  PasscodeKeyboardView.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

class PasscodeKeyboardView: UIView {
    
    private let buttonAdapters: [PasscodeKeyboardButtonType]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    var tapHandler: ((PasscodeKeyboardButtonType) -> Void)?
    
    init(buttons: [PasscodeKeyboardButtonType]) {
        self.buttonAdapters = buttons
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        var horizontalStackView = UIStackView()
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillEqually
        for (index, type) in buttonAdapters.enumerated() {
            let button = PasscodeKeyboardButton(type: type)
            button.tapHandler = didTapKeyboardButton(type:)
            if index % 3 == 0 {
                horizontalStackView = UIStackView()
                horizontalStackView.axis = .horizontal
                horizontalStackView.alignment = .center
                horizontalStackView.distribution = .fillEqually
                horizontalStackView.spacing = LayoutGuidance.offset
                horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            } else if index % 3 == 2 {
                stackView.addArrangedSubview(horizontalStackView)
                NSLayoutConstraint.activate([
                    horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor),
                    horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor)
                ])
            }
            horizontalStackView.addArrangedSubview(button)
        }
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func didTapKeyboardButton(type: PasscodeKeyboardButtonType) {
        tapHandler?(type)
    }
    
}
