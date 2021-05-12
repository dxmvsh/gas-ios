//
//  PaymentHistoryCell.swift
//  Gas
//
//  Created by Strong on 5/11/21.
//

import UIKit

class PaymentHistoryCell: UITableViewCell {
    
    private let dateLabel = UILabel().with(font: .systemFont(ofSize: 12)).with(textColor: Color.gray)
    private let accountNumberLabel = UILabel().with(font: .systemFont(ofSize: 16)).with(textColor: Color.darkGray)
    private let consumptionLabel = UILabel().with(font: .systemFont(ofSize: 14)).with(textColor: Color.gray)
    private let priceLabel = UILabel().with(font: .systemFont(ofSize: 16)).with(textColor: Color.success)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [dateLabel, accountNumberLabel, consumptionLabel, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGuidance.offsetDouble),
            dateLabel.centerYAnchor.constraint(equalTo: consumptionLabel.centerYAnchor),
            
            accountNumberLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            accountNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            accountNumberLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: LayoutGuidance.offsetHalf),
            
            consumptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutGuidance.offsetDouble),
            consumptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: consumptionLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: accountNumberLabel.bottomAnchor),
        ])
    }
    
    func configure(adapter: PaymentHistoryCellAdapter) {
        dateLabel.text = adapter.date
        accountNumberLabel.text = adapter.accountNumber
        consumptionLabel.text = adapter.consumption
        priceLabel.text = adapter.price
    }
}
