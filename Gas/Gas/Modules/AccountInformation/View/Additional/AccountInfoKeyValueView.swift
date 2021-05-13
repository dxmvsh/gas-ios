//
//  AccountInfoKeyValueView.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import UIKit

class AccountInfoKeyValueView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offsetHalf
        return stackView
    }()
    
    let titleLabel = UILabel().with(font: .systemFont(ofSize: 15))
                                      .with(textColor: Color.gray)
    
    let valueLabel = UILabel().with(font: .systemFont(ofSize: 13))
                                      .with(textColor: Color.darkGray)
                                      .with(numberOfLines: 0)
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = Color.lineGray2
        return view
    }()
    
    private let iconView = UIButton()
    
    var didTapIconViewClosure: (() -> Void)?
    
    init(title: String = "", value: String = "", hasBottomLine: Bool = false, hasClearIconView: Bool = false) {
        super.init(frame: .zero)
        titleLabel.text = title
        valueLabel.text = value
        bottomLine.isHidden = !hasBottomLine
        iconView.isHidden = !hasClearIconView
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [stackView, iconView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [titleLabel, valueLabel, bottomLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        iconView.setBackgroundImage(Asset.iconClear.image, for: .normal)
        iconView.addTarget(self, action: #selector(didTapIconView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor),
            
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconView.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc
    private func didTapIconView() {
        didTapIconViewClosure?()
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setValue(_ text: String) {
        valueLabel.text = text
    }
}
