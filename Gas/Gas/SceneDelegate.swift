//
//  SceneDelegate.swift
//  Gas
//
//  Created by Strong on 3/23/21.
//

import UIKit
import Anyline

let kLicenseKey = "eyJzY29wZSI6WyJBTEwiXSwicGxhdGZvcm0iOlsiaU9TIiwiQW5kcm9pZCIsIldpbmRvd3MiLCJKUyIsIldlYiJdLCJ2YWxpZCI6IjIwMjEtMDYtMjAiLCJtYWpvclZlcnNpb24iOjMsIm1heERheXNOb3RSZXBvcnRlZCI6NSwic2hvd1dhdGVybWFyayI6dHJ1ZSwicGluZ1JlcG9ydGluZyI6dHJ1ZSwiZGVidWdSZXBvcnRpbmciOiJvbiIsInRvbGVyYW5jZURheXMiOjUsInNob3dQb3BVcEFmdGVyRXhwaXJ5Ijp0cnVlLCJpb3NJZGVudGlmaWVyIjpbInNkdS5HYXMiXSwiYW5kcm9pZElkZW50aWZpZXIiOlsic2R1LkdhcyJdLCJ3aW5kb3dzSWRlbnRpZmllciI6WyJzZHUuR2FzIl0sIndlYklkZW50aWZpZXIiOlsic2R1LkdhcyJdLCJqc0lkZW50aWZpZXIiOlsic2R1LkdhcyJdLCJpbWFnZVJlcG9ydENhY2hpbmciOnRydWUsImxpY2Vuc2VLZXlWZXJzaW9uIjoyLCJhZHZhbmNlZEJhcmNvZGUiOnRydWUsInN1cHBvcnRlZEJhcmNvZGVGb3JtYXRzIjpbIkFMTCJdfQpZb1VFTXBmaEQ5NEg3NUR2M2pSWVZOOWJ5NWpvTGo1WGN4UHhnNTNHUjI2Q0V2S0VyaEhEZWxIQjdtZm9DeTlQN0tGOXVGVmV5US80d2Vlb2lEQ2oxQVBsaTZpMTJTQ1MvU1BDUU5nMW1IbC9kUElqZ2tsL2l4ajRFN0dzYkM3Z2pUQ29Ma2JnM0pnTmx2anMvM3NCc2t4NXk2c29EM3lBTnRpOE83ZEFpVzh1dkVTQzQ2WE1QeEhDUFk2Wlp5VXNWaWFUa1VzNlJKRkw3MkplRG9vYlZzZXpFNCt6c05mbUlvY3g4MkQ5OEU2YTJVMWxSWklMMUJZS3Jnb3U5Q1hUQWxKT1Z0Q2NMcHJvcStnYnFYQTRqekdwZEpmeUNjaTkzYWZBTnZzR291MUhDdUZsbnVhTFNLdDZLSE4yODJUcm5zWlN4WnRCaXgxUkFkRjJFN1UrNXc9PQ=="

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let view = InitialViewController()
        window?.rootViewController = UINavigationController(rootViewController: view)
        view.window = window
        window?.backgroundColor = Color.background
        window?.makeKeyAndVisible()
        
    }

}
