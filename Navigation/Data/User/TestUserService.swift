//
//  TestUserService.swift
//  Navigation
//
//  Created by Виталий Мишин on 23.10.2023.
//

import UIKit

class TestUserService: UserService {
    
    let testUser = User(userLogin: "test", userFullName: "test", userAvatar: UIImage(systemName: "person.circle") ?? UIImage(), userStatus: "test")
    
//    func authorization(userLogin: String) -> User? {
//        if userLogin == testUser.userLogin {
//            return testUser
//        } else {
//            return nil
//        }
//    }
    func authorization(userLogin: String) -> User? {
            userLogin == testUser.userLogin ? testUser : nil
        }
    
}
