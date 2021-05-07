//
//  IndicatorExtension.swift
//  Gas
//
//  Created by Strong on 4/11/21.
//

import UIKit

extension UIActivityIndicatorView: IndicatorProtocol {
    public var radius: CGFloat {
        get {
            return frame.width / 2
        }
        set {
            frame.size = CGSize(width: 2 * newValue, height: 2 * newValue)
            setNeedsDisplay()
        }
    }
    
    public var indicatorColor: UIColor {
        get {
            return color
        }
        set {
            color = newValue
        }

    }
    // unused
    public func setupAnimation(in layer: CALayer, size: CGSize) {}
}
