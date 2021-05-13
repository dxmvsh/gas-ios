//
//  AccountListCell.swift
//  Gas
//
//  Created by Strong on 5/13/21.
//

import UIKit

class AccountListCell: UITableViewCell {
    
    private let nameLabel = UILabel().with(font: .systemFont(ofSize: 15)).with(textColor: Color.darkGray)
    
    private let accountNumberLabel = UILabel().with(font: .systemFont(ofSize: 15)).with(textColor: Color.darkGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [nameLabel, accountNumberLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGuidance.offset),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            accountNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutGuidance.offset),
            accountNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            accountNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(model: AccountInformationDataModel) {
        nameLabel.text = model.full_name
        accountNumberLabel.text = model.number
    }
    
}
