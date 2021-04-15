//
//  ClearableDelegate.swift
//  Gas
//
//  Created by Strong on 4/11/21.
//

import UIKit


public protocol ClearableDelegate: class {
    func clear(view: UIView)
}

extension ClearableDelegate {
    func clear(view: UIView) {}
}
