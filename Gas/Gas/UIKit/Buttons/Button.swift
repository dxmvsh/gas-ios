//
//  Button.swift
//  Gas
//
//  Created by Strong on 4/7/21.
//

import UIKit

fileprivate enum Constants {
    static let cornerRadius: CGFloat = 8
}

class Button: UIButton {
    
    static func makePrimary(title: String = "") -> Button {
        let button = Button()
        button.setTitle(title, for: .normal)
        button.roundCorners(radius: Constants.cornerRadius)
        button.backgroundColor = Color.main
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Color.buttonInactiveTitleColor, for: .disabled)
        return button
    }
    
    static func makeSecondary(title: String = "") -> Button {
        let button = Button()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .none
        button.setTitleColor(Color.darkGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }
    
    static func makePaymentButton(leftTitle: String = "", rightTitle: String = "") -> Button {
        let button = Button()
        button.leftLabel.text = leftTitle
        button.rightLabel.text = rightTitle
        button.roundCorners(radius: Constants.cornerRadius)
        button.setTitle(nil, for: .normal)
        button.backgroundColor = Color.main
        return button
    }
    
    private let leftLabel = UILabel().with(textColor: .white).with(font: .systemFont(ofSize: 16))
    
    private let rightLabel = UILabel().with(textColor: .white).with(font: .systemFont(ofSize: 16, weight: .medium))
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [leftLabel, rightLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offset),
            leftLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offset),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGuidance.offset),
            
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance.offset),
            rightLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offset),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGuidance.offset),
        ])
    }
    
    func setDisabled() {
        isEnabled = false
        backgroundColor = Color.buttonInactiveBackgroundColor
        leftLabel.textColor = Color.buttonInactiveTitleColor
        rightLabel.textColor = Color.buttonInactiveTitleColor
    }
    
    func setEnabled() {
        isEnabled = true
        backgroundColor = Color.main
        leftLabel.textColor = .white
        rightLabel.textColor = .white
    }
    
    func setLeftTitle(_ text: String) {
        leftLabel.text = text
    }
    
}
