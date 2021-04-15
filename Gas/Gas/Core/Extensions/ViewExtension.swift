//
//  ViewExtension.swift
//  Gas
//
//  Created by Strong on 4/7/21.
//

import UIKit

extension UIView {
    
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func roundCorners(radius: CGFloat, corners: CACornerMask) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
    }
    
    func addShadow(offset: CGSize = CGSize.zero, color: UIColor = UIColor.gray, radius: CGFloat = 4.0, opacity: Float = 0.2) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
