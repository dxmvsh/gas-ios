//
//  CheckBoxTitledView.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

class CheckBoxTitledView: UIView {
    
    let titleLabel = UILabel().with(font: .systemFont(ofSize: 15))
                              .with(textColor: Color.textGray)
    
    let checkBoxButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Asset.checkboxEmpty.image, for: .normal)
        return button
    }()
    
    var isSelected: Bool = false {
        didSet {
            updateCheckBox()
            completion?(isSelected)
        }
    }
    
    var completion: ((_ isSelected: Bool) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [checkBoxButton, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        addTapGestureRecognizer()
        checkBoxButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            checkBoxButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkBoxButton.topAnchor.constraint(equalTo: topAnchor),
            checkBoxButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkBoxButton.widthAnchor.constraint(equalToConstant: LayoutGuidance.offsetThreeQuarter),
            checkBoxButton.heightAnchor.constraint(equalToConstant: LayoutGuidance.offsetThreeQuarter),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: LayoutGuidance.offsetHalf),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: checkBoxButton.centerYAnchor)
        ])
    }
    
    private func addTapGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func didTap() {
        isSelected.toggle()
    }
    
    private func updateCheckBox() {
        if isSelected {
            checkBoxButton.setBackgroundImage(Asset.checkboxSelected.image, for: .normal)
        } else {
            checkBoxButton.setBackgroundImage(Asset.checkboxEmpty.image, for: .normal)
        }
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setAttributedTitle(_ text: NSAttributedString) {
        titleLabel.attributedText = text
    }
    
}
