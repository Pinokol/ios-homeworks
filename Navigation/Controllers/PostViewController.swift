//
//  PostViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.07.2023.
//

import UIKit
import StorageService

final class PostViewController: UIViewController {

    var post: PostFeed
        
        init(post: PostFeed) {
            self.post = post
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = post.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(buttonAction))
    }
    
    @objc func buttonPressed(sender: UIButton) {
            dismiss(animated: true)
        }

    @objc private func buttonAction(sender: UIButton) {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .automatic
        infoViewController.modalTransitionStyle = .coverVertical
        present(infoViewController, animated: true)
    }

}
