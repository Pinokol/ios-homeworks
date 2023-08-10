//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Виталий Мишин on 29.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView = ProfileHeaderView()
    
    private lazy var profileButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4.0
        button.setTitle("New button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        button.setTitleShadowColor(.black, for: .application)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(self.profileHeaderView)
        view.addSubview(profileButton)
        setupConstraint()
        profileButton.addTarget(self, action: #selector (newButtonPressed), for: .touchUpInside)
        
    }
    
    @objc
    private func newButtonPressed(sender: UIButton) {
        if let buttonText = profileButton.currentTitle {
            print(buttonText)
        }
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupConstraint() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: 0),
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 0),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            profileButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 0),
            profileButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: 0),
            profileButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}

