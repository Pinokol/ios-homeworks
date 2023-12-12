//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Виталий Мишин on 27.11.2023.
//

import UIKit
import StorageService

final class FeedCoordinator: Coordinator {
    
    func presentPost(navigationController: UINavigationController? , title: String) {
        let postViewController = PostViewController(post: PostFeed(title: String()), coordinator: self)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func presentInfo(navigationController: UINavigationController?){
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .flipHorizontal
        infoViewController.modalPresentationStyle = .pageSheet
        navigationController?.present(infoViewController, animated: true)
    }
    
}
