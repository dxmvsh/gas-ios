//
//  AnalyticsCollectionViewCell.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

fileprivate enum Constants {
    static let imageViewOffset: CGFloat = 44
    static let cornerRadius: CGFloat = 14
}

class AnalyticsCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel().with(font: .systemFont(ofSize: 15, weight: .medium))
                                      .with(textColor: .white)
                                      .with(alignment: .center)
    
    private let valueLabel = UILabel().with(font: .systemFont(ofSize: 24))
                                      .with(alignment: .center)
                                      .with(textColor: .white)
    
    private let imageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [titleLabel, valueLabel, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        imageView.image = Asset.lineGraph.image
        backgroundColor = Color.main
        roundCorners(radius: Constants.cornerRadius)
        addGradient()
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGuidance.offset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageViewOffset),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.imageViewOffset),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGuidance.offset),
        ])
    }
    
    private func addGradient() {
        let layer = CAGradientLayer()
        layer.colors = [
          UIColor(red: 0.186, green: 0.754, blue: 0.992, alpha: 1).cgColor,
          UIColor(red: 0.038, green: 0.546, blue: 0.758, alpha: 1).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 1, y: 1)
        layer.endPoint = CGPoint(x: 0, y: 0)
        layer.frame = bounds
        layer.cornerRadius = Constants.cornerRadius
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
}
