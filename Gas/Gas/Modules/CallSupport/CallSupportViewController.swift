//
//  CallSupportViewController.swift
//  Gas
//
//  Created by Strong on 5/21/21.
//

import UIKit

class CallSupportViewController: BaseViewController {
    
    private let textLabel = UILabel().with(text: "Напишите причину вызова специалиста. Все подробности заявки будут высланы на почту").with(numberOfLines: 0).with(font: .systemFont(ofSize: 16)).with(textColor: Color.textGray)
    
    private let commentTextField = LabeledTextField(title: "Ваш комментарий")
    
    private let button = Button.makePrimary(title: "Отправить")
    
    var completionHandler: (() -> Void)?
    
    private let dataProvider = CommonService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        title = "Вызов специалиста"
        [textLabel, commentTextField, button].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        button.setDisabled()
        button.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        commentTextField.maskedDelegate = self
        view.addInputAccessoryForViews([commentTextField])
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGuidance.offsetAndHalf),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetAndHalf),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetAndHalf),
            
            commentTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: LayoutGuidance.offsetAndHalf),
            commentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetAndHalf),
            commentTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetAndHalf),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetAndHalf),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetAndHalf),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutGuidance.offset),
            button.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight)
        ])
    }
    
    @objc
    private func didTapSend() {
        dataProvider.sendComment(message: commentTextField.publicRealString) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.popViewController(animated: true)
                self?.completionHandler?()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}

extension CallSupportViewController: MaskedTextFieldDelegate {
    func textFieldDidEndEditing(_ textField: MaskedTextfield, reason: UITextField.DidEndEditingReason) {
        if !textField.publicRealString.isEmpty {
            button.setEnabled()
        } else {
            button.setDisabled()
        }
    }
}
