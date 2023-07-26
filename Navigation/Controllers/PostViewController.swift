//
//  PostViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.07.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Anonymous"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = titlePost
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(buttonAction))
    }
    
    @objc private func buttonAction() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .automatic
        infoViewController.modalTransitionStyle = .coverVertical
        present(infoViewController, animated: true)
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


