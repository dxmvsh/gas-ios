//
//  PasscodeKeyboardButton.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

enum PasscodeKeyboardButtonType {
    case custom(text: String)
    case empty
    case delete
}

class PasscodeKeyboardButton: UIButton {
    
    private var type: PasscodeKeyboardButtonType
    
    private var isValid: Bool {
        get {
            switch type {
            case .custom(let text):
                return !text.isEmpty
            default:
                return true
            }
        }
    }
    
    var tapHandler: ((PasscodeKeyboardButtonType) -> Void)?
    
    init(type: PasscodeKeyboardButtonType) {
        self.type = type
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        switch type {
        case .custom(let text):
            setTitle(text, for: .normal)
        case .delete:
            setImage(Asset.backspace.image, for: .normal)
        case .empty:
            setTitle(nil, for: .normal)
        }
        titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
    
    @objc
    private func didTap() {
        guard isValid else { return }
        tapHandler?(type)
    }
}
