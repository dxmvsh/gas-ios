//
//  LabelExtension.swift
//  Gas
//
//  Created by Strong on 4/1/21.
//

import UIKit

extension UILabel {
    func with(text: String) -> Self {
        self.text = text
        return self
    }
    
    func with(font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    func with(textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func with(numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    func with(alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
}
