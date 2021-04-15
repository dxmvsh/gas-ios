//
//  EditingAction.swift
//  Gas
//
//  Created by Strong on 4/11/21.
//

import Foundation

enum EditingAction {
    case copy
    case paste
    
    var selectorId: String {
        switch self {
        case .copy:
            return "copy:"
        case .paste:
            return "paste:"
        }
    }
}
