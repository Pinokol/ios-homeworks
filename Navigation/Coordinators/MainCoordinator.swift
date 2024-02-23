//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Виталий Мишин on 27.11.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var controller: UIViewController
    
    let tabBarVC = UITabBarController()
    
    init() {
        
        tabBarVC.tabBar.backgroundColor = .systemBackground
        controller = tabBarVC
        setup()
    }
    
    func setup() {
        tabBarVC.viewControllers = [self.createFeed(), createProfile(), createMedia()]
    }
    
    
    private func createFeed() -> UINavigationController {
        let coordinator = FeedCoordinator()
        return coordinator.feedNC
    }
    
    private func createProfile() -> UINavigationController {
        let profileCoordinator = ProfileCoordinator()
        return profileCoordinator.profileNC
    }
    
    private func createMedia() -> UINavigationController {
        let coordinator = MediaCoordinator()
        return coordinator.mediaNC
    }
    
}
