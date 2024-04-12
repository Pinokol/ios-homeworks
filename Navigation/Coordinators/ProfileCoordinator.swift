//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Виталий Мишин on 27.11.2023.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    var controller: UIViewController
    
    let loginVC = LogInViewController()
    let profileNC: UINavigationController
    
    init(){
        
        profileNC = UINavigationController(rootViewController: loginVC)
        profileNC.title = "Профиль"
        profileNC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        
        controller = profileNC
        setup()
    }
    
    func setup() {
        let loginFactory = MainFactory()
        loginVC.loginDelegate = loginFactory.makeLoginInspector()
        loginVC.coordinator = self
    }
    
    enum Presentation {
        case photo
        case profile
    }
    
    func present(_ presentation: Presentation, navigationController: UINavigationController?, userService: User?) {
        switch presentation {
        case .photo:
            let photoViewController = PhotosViewController()
            photoViewController.modalTransitionStyle = .flipHorizontal
            photoViewController.modalPresentationStyle = .pageSheet
            navigationController?.pushViewController(photoViewController, animated: true)
        case .profile:
            let profileViewController = ProfileViewController(userService: userService, coordinator: self)
            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}
