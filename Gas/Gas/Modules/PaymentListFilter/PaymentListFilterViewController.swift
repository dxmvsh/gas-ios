//
//  PaymentListFilterViewController.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

class PaymentListFilterViewController: UIViewController {
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Date().adjust(.year, offset: -10)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    private let checkBoxDescriptionView = CheckBoxDescriptionView()
    private let selectionView = PaymentFilterDateSelectionView()
    private let button = Button.makePrimary(title: "Подтвердить")
    private var type: PaymentListFilterType = .all
    var didTapSubmitHandler: ((PaymentListFilterType) -> Void)?
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        selectionView.didSelect = { [weak self] component in
            self?.didSelect(component)
        }
        checkBoxDescriptionView.setCheckBox { [weak self] isSelected in
            if isSelected {
                self?.type = .all
                self?.datePicker.isUserInteractionEnabled = false
                self?.selectionView.set(isSelected: false, component: .from)
                self?.selectionView.set(isSelected: false, component: .to)
            } else {
                self?.type = .period(from: nil, to: nil)
                self?.datePicker.isUserInteractionEnabled = true
                self?.selectionView.set(isSelected: true, component: .from)
                self?.selectionView.set(isSelected: false, component: .to)
            }
        }
        checkBoxDescriptionView.setDescription(text: "Все оплаты")
        button.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        [datePicker, checkBoxDescriptionView, selectionView, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            selectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            selectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectionView.heightAnchor.constraint(equalToConstant: 50),
            
            checkBoxDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetDouble),
            checkBoxDescriptionView.topAnchor.constraint(equalTo: selectionView.bottomAnchor, constant: LayoutGuidance.offset),
            
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: checkBoxDescriptionView.bottomAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            button.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: LayoutGuidance.offset),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset),
            button.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
        ])
    }
    
    func setTitle(_ text: String, for component: PaymentFilterDateSelectionViewComponent) {
        selectionView.setTitle(text, for: component)
    }
    
    func configure(type: PaymentListFilterType) {
        switch type {
        case .all:
            checkBoxDescriptionView.setCheckBox(selected: true)
            selectionView.setTitle("с", for: .from)
            selectionView.setTitle("до", for: .to)
        case .period(let fromDate, let toDate):
            let fromDateString = fromDate?.toString(format: .formatted_ddMMMyyyy)
            let toDateString = toDate?.toString(format: .formatted_ddMMMyyyy)
            selectionView.setTitle("с \(fromDateString ?? "")", for: .from)
            selectionView.setTitle("до \(toDateString ?? "")", for: .to)
            selectionView.set(isSelected: true, component: .from)
            selectionView.set(isSelected: false, component: .to)
        }
        self.type = type
    }
    
    @objc
    private func didTapSubmit() {
        didTapSubmitHandler?(type)
        dismiss(animated: true)
    }
    
    private func didSelect(_ component: PaymentFilterDateSelectionViewComponent) {
        switch component {
        case .from:
            switch type {
            case .period(let from, let to):
                if let from = from {
                    let fromDateString = from.toString(format: .formatted_ddMMMyyyy)
                    selectionView.setTitle("с \(fromDateString))", for: .from)
                    type = .period(from: from, to: to)
                    return
                }
                selectionView.setTitle("до \(datePicker.date.toString(format: .formatted_ISO8601))", for: .to)
                let fromDateString = datePicker.date.toString(format: .formatted_ddMMMyyyy)
                selectionView.setTitle("с \(fromDateString)", for: .from)
                type = .period(from: datePicker.date, to: to)
            case .all:
                let fromDateString = datePicker.date.toString(format: .formatted_ddMMMyyyy)
                selectionView.setTitle("с \(fromDateString)", for: .from)
                type = .period(from: datePicker.date, to: nil)
            }
        case .to:
            switch type {
            case .period(let from, let to):
                if let to = to {
                    let toDateString = to.toString(format: .formatted_ddMMMyyyy)
                    selectionView.setTitle("до \(toDateString))", for: .to)
                    type = .period(from: from, to: to)
                    return
                }
                selectionView.setTitle("с \(datePicker.date.toString(format: .formatted_ddMMMyyyy))", for: .from)
                let toDateString = datePicker.date.toString(format: .formatted_ddMMMyyyy)
                selectionView.setTitle("до \(toDateString)", for: .to)
                type = .period(from: from, to: datePicker.date)
            case .all:
                let toDateString = datePicker.date.toString(format: .formatted_ddMMMyyyy)
                selectionView.setTitle("до \(toDateString)", for: .to)
                type = .period(from: nil, to: datePicker.date)
            }
        }
    }
}
