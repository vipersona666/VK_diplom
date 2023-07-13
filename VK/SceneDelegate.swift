//
//  SceneDelegate.swift
//  VK
//
//  Created by Andrei on 10.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
//        let loginViewController = UINavigationController(rootViewController: LoginViewController())
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        let selectedViewController = UINavigationController(rootViewController: SelectedViewController())
    
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.viewControllers = [profileViewController, selectedViewController]
        tabBarController.viewControllers?[0].tabBarItem.title = "profile".localized
        tabBarController.viewControllers?[1].tabBarItem.title = "favorites".localized
        tabBarController.viewControllers?[0].tabBarItem.image = UIImage(systemName: "person")
        tabBarController.viewControllers?[1].tabBarItem.image = UIImage(systemName: "star")
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }

}

