//
//  MediaCoordinator.swift
//  Navigation
//
//  Created by Виталий Мишин on 22.01.2024.
//

import UIKit

final class MediaCoordinator: Coordinator {
    
    var controller: UIViewController
    let mediaVC = MediaViewController()
    let mediaNC: UINavigationController
    
    init(){
        mediaNC = UINavigationController(rootViewController: mediaVC)
        mediaNC.title = "Медиа"
        mediaNC.tabBarItem = UITabBarItem(title: "Медиа", image: UIImage(systemName:"doc.richtext"), tag: 0)
        controller = mediaNC
        setup()
    }
    
    func setup() {
        mediaVC.coordinator = self
    }
    
    enum Presentation {
        case media
        case recorder
    }
    
    func presentVoiceRecorder(navigationController: UINavigationController?){
        let voiceRecorderViewController = VoiceRecorderViewController()
        navigationController?.pushViewController(voiceRecorderViewController, animated: true)
    }
    
}

