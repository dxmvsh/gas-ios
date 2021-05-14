//
//  PaymentFilterDateSelectionComponentView.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

class PaymentFilterDateSelectionComponentView: UIView {
    
    private let label = UILabel().with(font: .systemFont(ofSize: 16)).with(alignment: .center)
    
    private let topLine = UIView()
    private let bottomLine = UIView()
    
    var tapHandler: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [topLine, label, bottomLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: topAnchor),
            topLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 1),
            
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance.offset),
            label.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: LayoutGuidance.offsetHalf),
            label.bottomAnchor.constraint(equalTo: bottomLine.topAnchor, constant: -LayoutGuidance.offsetHalf),
        ])
    }
    
    func setSelectedStyle() {
        backgroundColor = Color.main.withAlphaComponent(0.04)
        label.textColor = Color.main
        topLine.backgroundColor = Color.main
        bottomLine.backgroundColor = Color.main
    }
    
    func setDefaultStyle() {
        backgroundColor = .white
        label.textColor = Color.gray
        topLine.backgroundColor = Color.gray
        bottomLine.backgroundColor = Color.gray
    }
    
    func setTitle(_ text: String) {
        label.text = text
    }
    
    @objc
    private func didTap() {
        tapHandler?()
    }
}
