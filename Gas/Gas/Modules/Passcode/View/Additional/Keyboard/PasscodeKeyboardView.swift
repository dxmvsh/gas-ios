//
//  PasscodeKeyboardView.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

class PasscodeKeyboardView: UIView {
    
    private let buttons: [PasscodeKeyboardButtonType]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    init(buttons: [PasscodeKeyboardButtonType]) {
        self.buttons = buttons
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        var horizontalStackView = UIStackView()
        for (index, type) in buttons.enumerated() {
            if index % 3 == 0 {
                horizontalStackView = UIStackView()
                horizontalStackView.axis = .horizontal
                horizontalStackView.spacing = LayoutGuidance.offset
                horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            } else if index % 3 == 2 {
                stackView.addArrangedSubview(horizontalStackView)
                NSLayoutConstraint.activate([
                    horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor),
                    horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor)
                ])
            }
            horizontalStackView.addArrangedSubview(PasscodeKeyboardButton(type: type))
        }
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
}
