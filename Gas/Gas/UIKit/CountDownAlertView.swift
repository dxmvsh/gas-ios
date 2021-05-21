//
//  CountDownAlertView.swift
//  Gas
//
//  Created by Strong on 5/21/21.
//

import UIKit

private struct Constants {
    static let offset: CGFloat = 24.0
    static let offsetHalf: CGFloat = 12.0
    static let appearanceAnimationDuration: TimeInterval = 0.5
    static let unvisableYOffset: CGFloat = -200
    static let defaultSecondsLeft: Int = 5
    static let bottomUnvisibleYOffset: CGFloat = DeviceConstants.screenHeight + 200.0
}

protocol CountDownAlertViewDelegate: class {
    func timerDidRunOutOfTime()
}

enum CountDownAlerViewAppearanceStyle {
    case topdown
    case bottomup
}

final class CountDownAlertView: UIView {
    var actionHandler: (() -> (Void))?
    weak var delegate: CountDownAlertViewDelegate?
    private var appearanceStyle: CountDownAlerViewAppearanceStyle = .topdown
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(ofSize: 13)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.regular(ofSize: 13)
        return button
    }()
    
    private lazy var timer = {
        Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(countTimer),
                             userInfo: nil,
                             repeats: true)
    }()
    private var secondsLeft: Int
    private var actionButtonTitle: String

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String,
         appearanceStyle: CountDownAlerViewAppearanceStyle = .topdown,
         actionTitle: String,
         secondsLeft: Int) {
        self.secondsLeft = secondsLeft
        self.actionButtonTitle = actionTitle
        self.appearanceStyle = appearanceStyle
        super.init(frame: .zero)
        messageLabel.text = message
        actionButton.setTitle("\(actionTitle) \(secondsLeft)", for: .normal)
        setupUI()
    }
    
    init(message: String, appearanceStyle: CountDownAlerViewAppearanceStyle = .topdown) {
        self.secondsLeft = Constants.defaultSecondsLeft
        self.actionButtonTitle = ""
        self.appearanceStyle = appearanceStyle
        super.init(frame: .zero)
        messageLabel.text = message
        actionButton.isHidden = true
        setupUI()
    }
    
    func show(in view: UIView) {
        removeCountDownAlert(in: view)
        view.addSubview(self)
        self.frame = getRectForView(false)
        UIView.animate(withDuration: Constants.appearanceAnimationDuration) {
            self.frame = self.getRectForView(true)
        }
        startTimer()
    }
    
    private func removeCountDownAlert(in view: UIView) {
        view.subviews.forEach { subview in
            if subview as? CountDownAlertView != nil {
                subview.removeFromSuperview()
            }
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: Constants.appearanceAnimationDuration, animations: {
            self.frame = self.getRectForView(false)
        }) { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
    
    private func startTimer() {
        timer.fire()
    }
    
    @objc private func countTimer() {
        secondsLeft = secondsLeft - 1
        if secondsLeft == 0 {
            delegate?.timerDidRunOutOfTime()
            stopTimer()
            dismiss()
            return
        }
        actionButton.setTitle("\(actionButtonTitle) \(secondsLeft)", for: .normal)
    }
    
    private func stopTimer() {
        timer.invalidate()
    }
    
    private func getRectForView(_ show: Bool) -> CGRect {
        var yOffset: CGFloat = 0
        let height = messageLabel.intrinsicContentSize.height + LayoutGuidance.offsetDouble
        switch appearanceStyle {
        case .topdown:
            yOffset = show ? Constants.offset : Constants.unvisableYOffset
        case .bottomup:
            let visibleOffset = (superview?.frame.height ?? DeviceConstants.screenHeight)
                - height
                - (LayoutGuidance.offsetDouble + LayoutGuidance.offset)
            yOffset = show ? visibleOffset : Constants.bottomUnvisibleYOffset
        }
        return CGRect(x: 0, y: yOffset, width: DeviceConstants.screenWidth, height: height)
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(bgView)
        [messageLabel, actionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bgView.addSubview($0)
        }
        let buttonWidth = actionButton.intrinsicContentSize.width + Constants.offset
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offsetHalf),
            bgView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.offset),
            bgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.offset),
            
            messageLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: LayoutGuidance.offsetHalf),
            messageLabel.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: Constants.offsetHalf),
            messageLabel.rightAnchor.constraint(equalTo: actionButton.isHidden
                                                    ? bgView.rightAnchor
                                                    : actionButton.leftAnchor,
                                                constant: -Constants.offsetHalf),
            messageLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor,
                                                 constant: -LayoutGuidance.offsetHalf),
            
            actionButton.topAnchor.constraint(equalTo: bgView.topAnchor),
            actionButton.rightAnchor.constraint(equalTo: bgView.rightAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
        
        isUserInteractionEnabled = true
    }
    
    static func hide(from view: UIView) {
        view.subviews
            .filter { $0 is CountDownAlertView }
            .forEach { $0.removeFromSuperview() }
    }
}
