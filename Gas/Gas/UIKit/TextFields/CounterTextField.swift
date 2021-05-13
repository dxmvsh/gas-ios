//
//  CounterTextField.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

class CounterTextField: UITextField {
    
    var didEnterCode: ((String) -> Void)?
    
    var placeholderCharacter = "0"
    
    private var count: Int
    private var digitsLabel = [UILabel]()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = Color.lineGray2
        return view
    }()
    
    private let scanButton = UIButton()
    
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
         
        scanButton.setBackgroundImage(Asset.iconScanSmall.image, for: .normal)
        
        [stackView, scanButton, bottomLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuidance.offsetDouble),
            stackView.trailingAnchor.constraint(equalTo: scanButton.leadingAnchor, constant: -LayoutGuidance.offsetDouble),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scanButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: 24),
            scanButton.heightAnchor.constraint(equalToConstant: 24),
            scanButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            bottomLine.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGuidance.offsetHalf),
            bottomLine.widthAnchor.constraint(equalTo: widthAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
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
            let label = UILabel()
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
            resignFirstResponder()
        }
        
    }
    
    private func setEmptyStyle(for label: UILabel) {
        label.textColor = Color.lineGray2
    }
    
    private func setFiledStyle(for label: UILabel) {
        label.textColor = .black
    }
    
    func clear() {
        digitsLabel.forEach {
            $0.text = placeholderCharacter
            setEmptyStyle(for: $0)
            text = ""
        }
    }
}

extension CounterTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitsLabel.count || string.isEmpty
    }
    
}
