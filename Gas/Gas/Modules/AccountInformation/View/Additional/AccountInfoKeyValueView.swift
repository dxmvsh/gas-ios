//
//  AccountInfoKeyValueView.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import UIKit

class AccountInfoKeyValueView: UIView {
    
    private let titleLabel = UILabel().with(font: .systemFont(ofSize: 15))
                                      .with(textColor: Color.gray)
    
    private let valueLabel = UILabel().with(font: .systemFont(ofSize: 13))
                                      .with(textColor: Color.darkGray)
                                      .with(numberOfLines: 0)
    
    init(title: String = "", value: String = "") {
        super.init(frame: .zero)
        titleLabel.text = title
        valueLabel.text = value
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [titleLabel, valueLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offsetHalf),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setValue(_ text: String) {
        valueLabel.text = text
    }
}
