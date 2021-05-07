//
//  PasscodeStatusView.swift
//  Gas
//
//  Created by Strong on 4/27/21.
//

import UIKit

enum PasscodeMode {
    case set
    case enter
}

fileprivate enum Constants {
    static let passcodeCount: Int = 4
}

class PasscodeStatusView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    private let primaryInputView = PasscodeInputView(count: Constants.passcodeCount)
    private let secondaryInputView = PasscodeInputView(count: Constants.passcodeCount)
    
    private let mode: PasscodeMode
    
    private let feedback = UINotificationFeedbackGenerator()
    
    var completionHandler: (() -> Void)?
    
    init(mode: PasscodeMode) {
        self.mode = mode
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
        [primaryInputView, secondaryInputView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }

        secondaryInputView.isHidden = true
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func showFailure(completionHandler: @escaping () -> Void) {
        feedback.prepare()
        feedback.notificationOccurred(.error)
        shake()
        primaryInputView.showErrorState()
        secondaryInputView.showErrorState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.layoutIfNeeded()
            completionHandler()
        }
    }
    
    func setDefaultState() {
        secondaryInputView.isHidden = true
        primaryInputView.showDefaultState()
        secondaryInputView.showDefaultState()
    }
    
    func showSecondaryInputView() {
        secondaryInputView.isHidden = false
    }
    
    func set(highlighted: Bool, at index: Int) {
        switch mode {
        case .enter:
            setEnterPasscode(highlighted: highlighted, at: index)
        case .set:
            setConfigurePasscode(highlighted: highlighted, at: index)
        }
    }
    
    private func setEnterPasscode(highlighted: Bool, at index: Int) {
        guard index < Constants.passcodeCount else {
            completionHandler?()
            return
        }
        primaryInputView.set(highlighted: highlighted, at: index)
    }
    
    private func setConfigurePasscode(highlighted: Bool, at index: Int) {
        guard index < Constants.passcodeCount * 2 else {
            completionHandler?()
            return
        }
        if index < Constants.passcodeCount {
            primaryInputView.set(highlighted: highlighted, at: index)
        } else if index >= Constants.passcodeCount {
            let secondaryInputIndex = index - Constants.passcodeCount
            secondaryInputView.set(highlighted: highlighted, at: secondaryInputIndex)
        }
    }
}
