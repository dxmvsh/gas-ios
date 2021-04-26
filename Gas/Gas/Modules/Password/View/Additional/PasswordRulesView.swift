//
//  PasswordRulesView.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

class PasswordRulesView: UIView {
    
    private let imageView = UIImageView(image: Asset.infoIcon.image)
    private let titleLabel = LabelFactory.buildSubtitleLabel()
                                         .with(textColor: Color.main)
        .with(text: "Пароль должен содержать:")
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offsetHalf
        return stackView
    }()
    
    private var adapters: [PasswordRuleViewAdapter] = [] {
        didSet {
            updateStackViewContent()
        }
    }
    
    private var ruleLabels: [UILabel] = []
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [imageView, titleLabel, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: ViewSize.smallIcon),
            imageView.widthAnchor.constraint(equalToConstant: ViewSize.smallIcon),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LayoutGuidance.offsetQuarter),
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offsetHalf),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setAdapters(_ adapters: [PasswordRuleViewAdapter]) {
        self.adapters = adapters
    }
    
    private func updateStackViewContent() {
        stackView.arrangedSubviews.forEach(stackView.removeArrangedSubview(_:))
        ruleLabels.removeAll()
        adapters.forEach {
            let label = UILabel()
            label.textColor = Color.inactiveRuleColor
            label.text = $0.title
            ruleLabels.append(label)
            stackView.addArrangedSubview(label)
        }
    }
    
    func setLabel(isHighlighted: Bool, at index: Int) {
        ruleLabels[index].textColor = isHighlighted ? Color.darkGray : Color.inactiveRuleColor
    }
}
