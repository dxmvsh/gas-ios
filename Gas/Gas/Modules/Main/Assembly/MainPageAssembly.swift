//
//  MainPageAssembly.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

class MainPageAssembly {
    
    func assemble() -> UIViewController {
        let analyticsView = AnalyticsAssembly().assemble()
        let view = MainPageViewController(analyticsView: analyticsView)
        return view
    }
    
}
