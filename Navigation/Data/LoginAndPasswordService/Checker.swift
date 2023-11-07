//
//  Checker.swift
//  Navigation
//
//  Created by Виталий Мишин on 07.11.2023.
//

import Foundation

final class Checker {
    
    static let shared = Checker()
    // correctLogin совпадает с CurrentUserService userLogin
    private let correctLogin: String = "Tigr"
    private let correctPassword: String = "qwerty"
    
    private init() {}
    
    func check(inputLogin: String, inputPassword: String) -> Bool {
        let isCorrectLoginAndPassword = correctLogin == inputLogin && correctPassword == inputPassword
        return isCorrectLoginAndPassword
    }
}
