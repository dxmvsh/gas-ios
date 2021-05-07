//
//  FontExtension.swift
//  Gas
//
//  Created by Strong on 4/11/21.
//

import UIKit

extension UIFont {
    static func regular(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: .regular)
    }
    
    static func semibold(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: .semibold)
    }
    
    static func bold(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: .bold)
    }
}
