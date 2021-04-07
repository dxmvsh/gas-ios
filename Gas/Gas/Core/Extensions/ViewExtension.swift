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
    
}
