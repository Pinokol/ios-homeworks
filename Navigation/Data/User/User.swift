//
//  User.swift
//  Navigation
//
//  Created by Виталий Мишин on 23.10.2023.
//

import UIKit

public class User {
    var userLogin: String
    var userFullName: String
    var userAvatar: UIImage
    var userStatus: String
    
    init(userLogin: String, userFullName: String, userAvatar: UIImage, userStatus: String) {
        self.userLogin = userLogin
        self.userFullName = userFullName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}

protocol UserService {
    func authorization(userLogin: String) -> User?
}
