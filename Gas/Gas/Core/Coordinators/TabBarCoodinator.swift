//
//  TabBarCoodinator.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol TabBarCoordinatorProtocol {
    func start(index: Int)
}

class TabBarCoordinator: TabBarCoordinatorProtocol {
    
    private let tabBarController: UITabBarController
    private var window: UIWindow?
    
    init(tabBarController: UITabBarController, window: UIWindow?) {
        self.tabBarController = tabBarController
        self.window = window
    }
    
    func start(index: Int) {
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        setControllers()
        tabBarController.selectedIndex = index
    }
    
    func setControllers() {
        let viewController = MainPageAssembly().assemble()
        let mainPageViewController = UINavigationController(rootViewController: viewController)
        
        mainPageViewController.tabBarItem = UITabBarItem(title: nil,
                                                         image: Asset.iconHome.image,
                                                         selectedImage: Asset.iconHomeSelected.image)
        let viewController1 = PaymentHistoryAssembly().assemble()
        let paymentHistoryViewController = UINavigationController(rootViewController: viewController1)
        
        paymentHistoryViewController.tabBarItem = UITabBarItem(title: nil,
                                                               image: Asset.iconReceipt.image,
                                                               selectedImage: Asset.iconReceipt.image)
        
        let viewController2 = PaymentOrderAssembly().assemble()
        let scanViewController = UINavigationController(rootViewController: viewController2)
        scanViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: Asset.iconScan.image,
                                                     selectedImage: Asset.iconScan.image)
        
        let viewController3 = ProfileAssembly().assemble()
        let profileViewController = UINavigationController(rootViewController: viewController3)
        
        profileViewController.tabBarItem = UITabBarItem(title: nil,
                                                        image: Asset.iconAccount.image,
                                                        selectedImage: Asset.iconAccountSelected.image)
        
        let viewController4 = SettingsAssembly().assemble()
        let settingsViewController = UINavigationController(rootViewController: viewController4)
        settingsViewController.tabBarItem = UITabBarItem(title: nil,
                                                         image: Asset.iconSettings.image,
                                                         selectedImage: Asset.iconSettingsSelected.image)
        
        tabBarController.setViewControllers([mainPageViewController, paymentHistoryViewController, scanViewController, profileViewController, settingsViewController], animated: false)
    }
    
}
