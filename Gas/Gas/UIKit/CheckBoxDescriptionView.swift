//
//  CheckBoxDescriptionViiew.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//
import UIKit

fileprivate enum Constants {
    static let checkBoxButtonSize: CGFloat = 24
}

class CheckBoxDescriptionView: UIView {
    
    private let checkBoxButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setImage(Asset.checkboxEmpty.image, for: .normal)
        button.setImage(Asset.checkboxSelected.image, for: .selected)
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    private var actionHandler: ((_ isSelected: Bool) -> Void)?
    
    var isSelected: Bool {
        return checkBoxButton.isSelected
    }
    
    var label: UILabel {
        return descriptionLabel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        [checkBoxButton, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
        NSLayoutConstraint.activate([
            checkBoxButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkBoxButton.topAnchor.constraint(equalTo: topAnchor),
            checkBoxButton.widthAnchor.constraint(equalToConstant: Constants.checkBoxButtonSize),
            checkBoxButton.heightAnchor.constraint(equalToConstant: Constants.checkBoxButtonSize),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: checkBoxButton.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: LayoutGuidance.offsetHalf),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setDescription(text: String) {
        descriptionLabel.text = text
    }
    
    func setCheckBox(actionHandler: ((_ isSelected: Bool) -> Void)?) {
        self.actionHandler = actionHandler
    }
    
    func setCheckBox(selected: Bool) {
        checkBoxButton.isSelected = selected
        actionHandler?(checkBoxButton.isSelected)
    }
    
    func setDescriptionStyleSecondary() {
        descriptionLabel.font = .regular(ofSize: 13)
        descriptionLabel.textColor = Color.lineGray
    }
    
    @objc
    private func buttonTapped() {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        actionHandler?(checkBoxButton.isSelected)
    }
    
}
