//
//  SettingsCell.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    private let nameLabel = UILabel().with(font: .systemFont(ofSize: 16)).with(textColor: Color.darkGray)
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isHidden = true
        switcher.onTintColor = Color.main
        switcher.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        return switcher
    }()
    
    private let disclosureIndicator = UIImageView(image: Asset.iconNext.image)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [nameLabel, switcher, disclosureIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGuidance.offset),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGuidance.offset),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutGuidance.offset),
            
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutGuidance.offset),
            switcher.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
            disclosureIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutGuidance.offset),
            disclosureIndicator.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            disclosureIndicator.widthAnchor.constraint(equalToConstant: 24),
            disclosureIndicator.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func configure(text: String, hasSwitch: Bool = false, isOn: Bool = false) {
        nameLabel.text = text
        if hasSwitch {
            switcher.isHidden = false
            disclosureIndicator.isHidden = true
            switcher.isOn = isOn
        } else {
            switcher.isHidden = true
            disclosureIndicator.isHidden = false
        }
    }
    
    func setDisabled() {
        switcher.isOn = false
        switcher.isUserInteractionEnabled = false
        isUserInteractionEnabled = false
    }
    
}
