//
//  PasscodeViewController.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

fileprivate enum Constants {
    static let keyboardOffset: CGFloat = 72
    static let passcodeCount: Int = 4
    static let setPasscodeKeyboard: [PasscodeKeyboardButtonType] = [
        .custom(text: "1"), .custom(text: "2"), .custom(text: "3"),
        .custom(text: "4"), .custom(text: "5"), .custom(text: "6"),
        .custom(text: "7"), .custom(text: "8"), .custom(text: "9"),
        .empty, .custom(text: "0"), .delete
    ]
    static let enterPasscodeKeyboard: [PasscodeKeyboardButtonType] = [
        .custom(text: "1"), .custom(text: "2"), .custom(text: "3"),
        .custom(text: "4"), .custom(text: "5"), .custom(text: "6"),
        .custom(text: "7"), .custom(text: "8"), .custom(text: "9"),
        .biometry, .custom(text: "0"), .delete
    ]
}

class PasscodeViewController: BaseViewController, PasscodeViewInput {
    
    private let mode: PasscodeMode
    
    private lazy var statusView = PasscodeStatusView(mode: mode)
    private lazy var keyboardView: PasscodeKeyboardView = {
        switch mode {
        case .enter:
            return PasscodeKeyboardView(buttons: Constants.enterPasscodeKeyboard)
        case .set:
            return PasscodeKeyboardView(buttons: Constants.setPasscodeKeyboard)
        }
    }()
    
    var output: PasscodeViewOutput?
    
    init(mode: PasscodeMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        addHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var enteredPasscode: String = "" {
        didSet {
            didChangePasscode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        switch mode {
        case .set:
            addTitleAndSubtitleLabels(title: Text.pinCode, subtitle: Text.setPinCodeForFastAccess)
        case .enter:
            backButtonTapHandler = { [weak self] in
                self?.output?.didTapBack()
                self?.navigationController?.popViewController(animated: true)
            }
            addTitleAndSubtitleLabels(title: Text.pinCode, subtitle: Text.enterPinCodeForAccess)
        }
        
        setupViews()
        addHandlers()
    }
    
    private func setupViews() {
        [statusView, keyboardView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGuidance.offsetAndHalf),
            statusView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.keyboardOffset),
            keyboardView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: LayoutGuidance.offsetDouble),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.keyboardOffset),
        ])
    }
    
    private func addHandlers() {
        keyboardView.tapHandler = { [weak self] type in
            switch type {
            case .custom(let digit):
                self?.enteredPasscode += digit
            case .biometry:
                // Add biometry
                break
            case .delete:
                self?.enteredPasscode.removeLast()
            default:
                break
            }
        }
    }
    
    private func didChangePasscode() {
        var count = 0
        switch mode {
        case .set:
            count = Constants.passcodeCount * 2
            if enteredPasscode.count == Constants.passcodeCount {
                UIView.animate(withDuration: 0.6) {
                    self.statusView.showSecondaryInputView()
                }
            }
        case .enter:
            count = Constants.passcodeCount
        }
        
        for index in 0..<count {
            if (0..<enteredPasscode.count).contains(index) {
                statusView.set(highlighted: true, at: index)
            } else {
                statusView.set(highlighted: false, at: index)
            }
        }
        if enteredPasscode.count >= count {
            output?.didEnterPasscode(enteredPasscode)
        }
    }
    
    func showError() {
        statusView.showFailure { [weak self] in
            self?.statusView.setDefaultState()
        }
    }
    
}
