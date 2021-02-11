//
//  SceneDelegate.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let navVC = window?.rootViewController as? UINavigationController,
           let rootVC = navVC.topViewController as? ViewController,
           let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            rootVC.container = appDelegate.persistentContainer
        }
    }
 
}

