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
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ImageTigr"))
        imageView.backgroundColor = .green
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 47.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Hipster Tigr"
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let statusLabel: UILabel = {
        let signature = UILabel()
        signature.text = "Listening to music"
        signature.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        signature.textColor = .gray
        signature.translatesAutoresizingMaskIntoConstraints = false
        return signature
    }()
    
    private lazy var setStatusButton: UIButton = {
        
        let button = UIButton()
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.backgroundColor = .blue
        button.layer.cornerRadius = 14.0
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        button.setTitleShadowColor(.black, for: .application)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var statusTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "введите новый статус здесь"
        
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setStatusButton.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonPressed(sender: UIButton) {
        if let buttonText = setStatusButton.currentTitle {
            print(buttonText)
        }
    }
    
    @objc
    private func tapOnButton(sender: UIButton) {
        onDetailShow?()
    }
    
    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
        
        
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 94),
            avatarImageView.heightAnchor.constraint(equalToConstant: 94),
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27),
            fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 46),
            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.widthAnchor.constraint(equalToConstant: 360),
            
            
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -65),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -14),
            statusLabel.rightAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 155),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 35),
            statusTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 35),
            statusTextField.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: -16),
            
            
        ])
        
    }
    
}
