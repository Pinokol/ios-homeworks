//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Виталий Мишин on 23.10.2023.
//

import UIKit

class CurrentUserService: UserService {
    
    let currentUser = User(userLogin: "Tigr", userFullName: "Siberian Tigr", userAvatar: UIImage(named: "ImageTigr") ?? UIImage(), userStatus: "Do good")
    
//    func authorization(userLogin: String) -> User? {
//
//        if userLogin == currentUser.userLogin {
//            return currentUser
//        } else {
//            return nil
//        }
//    }
    func authorization(userLogin: String) -> User? {
            userLogin == currentUser.userLogin ? currentUser : nil
        }
}
