//
//  SceneDelegate.swift
//  Chucknorris
//
//  Created by Виталий Мишин on 11.03.2024.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let mainCoordinator = MainCoordinator()
        window.rootViewController = mainCoordinator.start()
        window.makeKeyAndVisible()
        self.window = window
    }
    
}
