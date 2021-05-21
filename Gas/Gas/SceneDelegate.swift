//
//  SceneDelegate.swift
//  Gas
//
//  Created by Strong on 3/23/21.
//

import UIKit
import BlinkInput

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        MBIMicroblinkSDK.shared().setLicenseKey("sRwAAAEHc2R1Lmdhc5gpZPfivfI7wlg+MM3ka0uU1kjEembO9PDg6ouovRtDJoHrKZtX/HnnDdP3PDkAM6D61Kf3pN2nMqXA83LsOzQS2DQnzeshqSfnb1C4n/dJL/E6bqKJ5Hg3/zDPSx3A5xmPwTUOpXky65uCADkUFlnfHJO8DUemyquAOegGe+m8fGLF9dgCBX7Y8UWZutGrKgs=") { error in
            print("blink input error: \(error)")
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let view = InitialViewController()
        window?.rootViewController = UINavigationController(rootViewController: view)
        view.window = window
        window?.backgroundColor = Color.background
        window?.makeKeyAndVisible()
        
    }

}
