//
//  InfoViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 13.07.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.button)
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    @objc private func buttonAction() {
        let alert = UIAlertController()
        
        alert.title = "Алёрт"
        alert.message = "Ура!!!\nУ нас получился алёрт"
        alert.addAction(UIAlertAction(title: "1", style: .default, handler: { _ in
            print("1")
        }))
        alert.addAction(UIAlertAction(title: "2", style: .default, handler: { _ in
            print("2")
        }))
        
        self.present(alert, animated: true)
    }
    
}

