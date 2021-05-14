//
//  SettingsHeaderView.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

class SettingsHeaderView: UIView {
    
    private let label = UILabel().with(font: .systemFont(ofSize: 14)).with(textColor: Color.gray)
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        backgroundColor = Color.headerBackground
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance.offset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offsetThreeQuarter),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGuidance.offsetThreeQuarter),
        ])
    }
    
    func setText(_ text: String) {
        label.text = text
    }
}
