//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Виталий Мишин on 29.07.2023.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var avatarBackground = UIView()
    var returnAvatarButton = UIButton()
    private var statusText: String = ""
    private var avatarOriginPoint = CGPoint()
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
        signature.text = "Waiting for something..."
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
        textField.placeholder = "Set your status.."
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        addTarget()
        statusTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTarget() {
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    @objc
    private func buttonPressed(sender: UIButton) {
        if let buttonText = setStatusButton.currentTitle {
            print(buttonText)
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubviews(avatarBackground, avatarImageView, returnAvatarButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnAvatar))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
        
        // cancel an animation mode
        returnAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        returnAvatarButton.alpha = 0
        returnAvatarButton.backgroundColor = .clear
        returnAvatarButton.contentMode = .scaleToFill
        returnAvatarButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.black, renderingMode: .automatic), for: .normal)
        returnAvatarButton.tintColor = .black
        returnAvatarButton.addTarget(self, action: #selector(returnAvatarToOrigin), for: .touchUpInside)
        
        avatarBackground = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        avatarBackground.backgroundColor = .darkGray
        avatarBackground.isHidden = true
        avatarBackground.alpha = 0
        
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 94),
            avatarImageView.heightAnchor.constraint(equalToConstant: 94),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 46),
            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.widthAnchor.constraint(equalToConstant: 360),
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -65),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -14),
            statusLabel.rightAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 165),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 35),
            statusTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 10),
            statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            returnAvatarButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            returnAvatarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapOnAvatar() {
        avatarImageView.isUserInteractionEnabled = false
        ProfileViewController.postTableView.isScrollEnabled = false
        ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
        avatarOriginPoint = avatarImageView.center
        let scale = UIScreen.main.bounds.width / avatarImageView.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                  y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarBackground.isHidden = false
            self.avatarBackground.alpha = 0.7
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.returnAvatarButton.alpha = 1
            }
        }
    }
    
    @objc private func returnAvatarToOrigin() {
        UIImageView.animate(withDuration: 0.5) {
            UIImageView.animate(withDuration: 0.5) {
                self.returnAvatarButton.alpha = 0
                self.avatarImageView.center = self.avatarOriginPoint
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                self.avatarBackground.alpha = 0
            }
        } completion: { _ in
            ProfileViewController.postTableView.isScrollEnabled = true
            ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
            self.avatarImageView.isUserInteractionEnabled = true
        }
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
