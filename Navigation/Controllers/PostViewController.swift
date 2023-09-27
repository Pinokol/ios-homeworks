//
//  PostViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.07.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Post"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = titlePost
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(buttonAction))
    }
    
    @objc private func buttonAction(sender: UIButton) {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .automatic
        infoViewController.modalTransitionStyle = .coverVertical
        present(infoViewController, animated: true)
    }
    
}
