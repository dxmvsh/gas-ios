//
//  SettingsAssembly.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

class SettingsAssembly {
    
    func assemble(logoutHandler: (() -> Void)?) -> UIViewController {
        let view = SettingsViewController()
        view.logoutHandler = logoutHandler
        return view
    }
    
}
