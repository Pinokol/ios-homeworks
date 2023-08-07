//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Виталий Мишин on 29.07.2023.
//

import UIKit

typealias Action = (() -> Void)

final class ProfileHeaderView: UIView {
    
    var onDetailShow: Action?
    
    private let tigrImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ImageTigr"))
        imageView.backgroundColor = .green
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 47.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileName: UILabel = {
        let name = UILabel()
        name.text = "Hipster Tigr"
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let profileSignature: UILabel = {
        let signature = UILabel()
        signature.text = "Waiting for somethink..."
        signature.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        signature.textColor = .gray
        signature.translatesAutoresizingMaskIntoConstraints = false
        return signature
    }()
    
    private lazy var showStatusButton: UIButton = {
        
        let button = UIButton()
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.backgroundColor = .blue
        button.layer.cornerRadius = 14.0
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        button.setTitleShadowColor(.black, for: .application)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTarget() {
        showStatusButton.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
    }
    
    @objc
    private func buttonPressed(sender: UIButton) {
        if let buttonText = showStatusButton.currentTitle {
            print(buttonText)
        }
    }
    
    @objc
    private func tapOnButton(sender: UIButton) {
        
        onDetailShow?()
        
    }
    
    private func setupUI() {
        addSubview(tigrImageView)
        addSubview(profileName)
        addSubview(showStatusButton)
        addSubview(profileSignature)
        
        NSLayoutConstraint.activate([
            tigrImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            tigrImageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tigrImageView.widthAnchor.constraint(equalToConstant: 94),
            tigrImageView.heightAnchor.constraint(equalToConstant: 94),
        ])
        
        NSLayoutConstraint.activate([
            profileName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            profileName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            showStatusButton.topAnchor.constraint(equalTo: tigrImageView.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            showStatusButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            showStatusButton.widthAnchor.constraint(equalToConstant: 360)
        ])
        
        NSLayoutConstraint.activate([
            profileSignature.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -34),
            profileSignature.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
