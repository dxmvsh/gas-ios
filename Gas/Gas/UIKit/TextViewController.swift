//
//  TextViewController.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

fileprivate enum Constants {
    static let mockText: String =
"""
АО «КазТрансГаз» является основной газоэнергетической и газотранспортной компанией Республики Казахстан, представляющей интересы государства как на отечественном, так и зарубежном газовом рынке.
    
Компания управляет централизованной инфраструктурой по транспортировке товарного газа по магистральным газопроводам и газораспределительным сетям, обеспечивает международный транзит и занимается продажей газа на внутреннем и внешнем рынках, разрабатывает, финансирует, строит и эксплуатирует трубопроводы и газохранилища.euse.
"""
}

class TextViewController: BaseViewController {
    
    private let label = UILabel().with(font: .systemFont(ofSize: 16)).with(numberOfLines: 0).with(textColor: Color.darkGray)
    
    init(title: String, text: String = Constants.mockText) {
        super.init(nibName: nil, bundle: nil)
        label.text = text
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupViews()
    }
    
    private func setupViews() {
        [label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGuidance.offset),
        ])
    }
    
}
