//
//  ViewExtension.swift
//  Gas
//
//  Created by Strong on 4/7/21.
//

import UIKit

extension UIView: CustomToolbarOutput {
    
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
    
    func addInputAccessoryForViews(_ views: [UIView]) {
        for (_, view) in views.enumerated() {
            let toolbar = CustomToolbar()
            toolbar.output = self
            var items = [UIBarButtonItem]()
            if let toolbarItems = toolbar.items {
                items.append(contentsOf: toolbarItems)
            }
            toolbar.setItems(items, animated: false)
            if let input = view as? UITextView {
                input.inputAccessoryView = toolbar
            }
            if let input = view as? UITextField {
                input.inputAccessoryView = toolbar
            }
        }
    }
    
    func toolbarDonePressed() {
        endEditing(true)
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
