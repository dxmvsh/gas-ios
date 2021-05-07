//
//  OfferConfirmationView.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

class OfferConfirmationView: UIView {
    
    private let checkBoxView: CheckBoxTitledView = {
        let view = CheckBoxTitledView()
        let title = NSMutableAttributedString(string: Text.iAgreeWith)
        let highlightedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.darkGray
        ]
        let highlightedText = NSAttributedString(string: " \(Text.withOfferConditions)",
                                                 attributes: highlightedTextAttributes)
        title.append(highlightedText)
        view.setAttributedTitle(title)
        return view
    }()
    
    private let continueButton = Button.makePrimary(title: Text.continue)
    
    var completion: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [checkBoxView, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        checkBoxView.completion = { [weak self] isSelected in
            if isSelected {
                self?.continueButton.setEnabled()
            } else {
                self?.continueButton.setDisabled()
            }
        }
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        continueButton.setDisabled()
        
        NSLayoutConstraint.activate([
            checkBoxView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offsetAndHalf),
            checkBoxView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offsetDouble),
            checkBoxView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance.offsetDouble),
            
            continueButton.topAnchor.constraint(equalTo: checkBoxView.bottomAnchor, constant: LayoutGuidance.offsetAndHalf),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offset),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance.offset),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGuidance.offsetDouble),
            continueButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight)
        ])
    }
    
    @objc
    private func didTapContinue() {
        completion?()
    }
    
}
