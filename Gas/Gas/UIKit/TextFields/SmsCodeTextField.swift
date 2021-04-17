//
//  SmsCodeTextField.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import UIKit

class SmsCodeTextField: UITextField {
    
    var didEnterCode: ((String) -> Void)?
    
    var placeholderCharacter = "•"
    
    private var count: Int
    private var digitsLabel = [SmsCodeDigitLabel]()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutGuidance.offsetHalf
        return stackView
    }()
    
    private let errorLabel = UILabel()
        .with(font: .systemFont(ofSize: 14))
        .with(alignment: .center)
        .with(textColor: Color.fail)
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    init(count: Int = 4,
         placeholderCharacter: String = "•") {
        self.count = count
        self.placeholderCharacter = placeholderCharacter
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        configureTextField()
        addLabelsToStackView()
        addGestureRecognizer(tapGestureRecognizer)
         
        [stackView, errorLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        errorLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGuidance.offset),
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func addLabelsToStackView() {
        for _ in 1...count {
            let label = SmsCodeDigitLabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .systemFont(ofSize: FontSize.bigSize)
            label.isUserInteractionEnabled = true
            label.text = placeholderCharacter
            
            setEmptyStyle(for: label)
            stackView.addArrangedSubview(label)
            digitsLabel.append(label)
        }
    }
    
    @objc
    private func textDidChange() {
        guard let text = text,
              text.count <= count else { return }
        errorLabel.isHidden = true
        
        for index in 0..<digitsLabel.count {
            let currentLabel = digitsLabel[index]
            
            if index < text.count {
                let index = text.index(text.startIndex, offsetBy: index)
                currentLabel.text = String(text[index])
                setFiledStyle(for: currentLabel)
            } else {
                currentLabel.text = placeholderCharacter
                setEmptyStyle(for: currentLabel)
            }
        }
        
        if text.count == digitsLabel.count {
            didEnterCode?(text)
        }
    }
    
    private func setEmptyStyle(for label: UILabel) {
        label.textColor = Color.lineGray2
    }
    
    private func setFiledStyle(for label: UILabel) {
        label.textColor = .black
    }
    
    private func setErrorStyle(for label: UILabel) {
        label.textColor = Color.fail
    }
    
    func showError(message: String) {
        digitsLabel.forEach {
            setErrorStyle(for: $0)
            $0.setNeedsLayout()
        }
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}

extension SmsCodeTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitsLabel.count || string.isEmpty
    }
    
}
