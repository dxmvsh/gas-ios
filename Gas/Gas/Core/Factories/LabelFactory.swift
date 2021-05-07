//
//  LabelFactory.swift
//  Gas
//
//  Created by Strong on 4/1/21.
//

import UIKit

enum LabelFactory {
    static func buildTitleLabel() -> UILabel {
        return UILabel()
            .with(font: .boldSystemFont(ofSize: FontSize.bigSize))
            .with(textColor: Color.darkGray)
    }
    
    static func buildSubtitleLabel() -> UILabel {
        return UILabel()
            .with(font: .systemFont(ofSize: FontSize.regularSize))
            .with(textColor: Color.textGray)
    }
}
