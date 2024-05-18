//
//  TestUserService.swift
//  Navigation
//
//  Created by Виталий Мишин on 23.10.2023.
//

import UIKit

final class TestUserService: UserService {
    
    let testUser = User(userLogin: "test", userFullName: "test", userAvatar: UIImage(systemName: "person.circle") ?? UIImage(), userStatus: "test")
    
    func authorization() -> User? {
        return testUser
    }
    
}
