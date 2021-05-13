//
//  AccountListHeaderView.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

class AccountListHeaderView: UITableViewHeaderFooterView {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.add, for: .normal)
        button.setTitle("Добавить лицевой счет", for: .normal)
        button.tintColor = Color.main
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
