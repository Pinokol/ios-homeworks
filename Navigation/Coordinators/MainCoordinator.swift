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
        tabBarVC.viewControllers = [self.createFeed(), createProfile(), createFavorite()]
    }
    
    
    private func createFeed() -> UINavigationController {
        let coordinator = FeedCoordinator()
        let feedNC = UINavigationController(rootViewController: FeedViewController())
        feedNC.title = "feed".localized
        feedNC.tabBarItem = UITabBarItem(title: "feed".localized, image: UIImage(systemName:"doc.richtext"), tag: 0)
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
    
    private func addControllersToTabBar(){
        tabBarVC.viewControllers = [createFeed(), createProfile(), createFavorite()]
    }
    
    private func createFavorite() -> UINavigationController {
        
        let service = FavoriteService(coreDataService: CoreDataService.shared)
        
        let favoriteViewController = FavoriteViewController(service: service)
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)
        favoriteNavigationController.title = "favorites".localized
        favoriteNavigationController.tabBarItem = UITabBarItem(title: "favorites".localized, image: UIImage(systemName: "star"), tag: 2)
        return favoriteNavigationController
    }
    
}
