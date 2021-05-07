//
//  SmsCodeDigitLabel.swift
//  Gas
//
//  Created by Strong on 4/17/21.
//

import UIKit

class SmsCodeDigitLabel: UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomBorder()
    }
    
    func addBottomBorder() {
        if let borderLayer = layer.sublayers?.first(where: { $0.name == "BorderSublayer" }) {
            borderLayer.backgroundColor = textColor.cgColor
            return
        }
        let borderLayer = CAShapeLayer()

        borderLayer.name = "BorderSublayer"
        
        borderLayer.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)
        borderLayer.backgroundColor = textColor.cgColor
        layer.insertSublayer(borderLayer, at: 0)
    }
}
