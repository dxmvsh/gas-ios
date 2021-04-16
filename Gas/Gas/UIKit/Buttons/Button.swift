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
        button.setTitleColor(Color.buttonInactiveTitleColor, for: .disabled)
        return button
    }
    
    static func makeSecondary(title: String = "") -> Button {
        let button = Button()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .none
        button.setTitleColor(Color.darkGray, for: .normal)
        return button
    }
    
    func setDisabled() {
        isEnabled = false
        backgroundColor = Color.buttonInactiveBackgroundColor
    }
    
    func setEnabled() {
        isEnabled = true
        backgroundColor = Color.main
    }
    
}
