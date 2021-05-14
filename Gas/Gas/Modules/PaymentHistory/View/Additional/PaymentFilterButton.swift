//
//  PaymentFilterButton.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

class PaymentFilterButton: UIView {
    
    private let label = UILabel().with(text: "Все платежи").with(font: .systemFont(ofSize: 16)).with(textColor: Color.darkGray)
    private let imageView = UIImageView(image: Asset.iconArrowDown.image)
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
        bottomLine.backgroundColor = Color.lineGray
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        [label, imageView, bottomLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offset),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: LayoutGuidance.offsetHalf),
            
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuidance.offset),
            imageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 16),
            
            bottomLine.topAnchor.constraint(equalTo: label.bottomAnchor, constant: LayoutGuidance.offsetHalf),
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    private func didTap() {
        tapHandler?()
    }
    
}
