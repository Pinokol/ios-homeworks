//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Виталий Мишин on 27.11.2023.
//

import UIKit
import StorageService

final class FeedCoordinator: Coordinator {
    
    var controller: UIViewController
    let feedVC = FeedViewController()
    let feedNC: UINavigationController
    
    init(){
        feedNC = UINavigationController(rootViewController: feedVC)
        feedNC.title = "Лента"
        feedNC.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName:"doc.richtext"), tag: 0)
        controller = feedNC
        setup()
    }
    
    func setup() {
        feedVC.coordinator = self
    }
    
    enum Presentation {
        case post
        case info
    }
    
    func present(_ presentation: Presentation, title: String) {
        switch presentation {
        case .post:
            let postViewController = PostViewController(post: PostFeed(title: title), coordinator: self)
            feedNC.pushViewController(postViewController, animated: true)
        case .info:
            let infoViewController = InfoViewController()
            infoViewController.modalTransitionStyle = .flipHorizontal
            infoViewController.modalPresentationStyle = .pageSheet
            feedNC.present(infoViewController, animated: true)
        }
    }
    
}
