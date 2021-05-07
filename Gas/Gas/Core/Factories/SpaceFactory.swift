//
//  SpaceFactory.swift
//  Gas
//
//  Created by Strong on 4/1/21.
//

import UIKit

enum SpaceFactory {
    static func build(with size: CGSize) -> UIView {
        let view = UIView()
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: view,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: size.width)
        let heightConstraint = NSLayoutConstraint(item: view,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .height,
                                                 multiplier: 1,
                                                 constant: size.height)
        view.addConstraints([widthConstraint, heightConstraint])
        return view
    }
}
