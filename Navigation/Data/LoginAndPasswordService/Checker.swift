//
//  Checker.swift
//  Navigation
//
//  Created by Виталий Мишин on 07.11.2023.
//

import Foundation

final class Checker {
    
    static let shared = Checker()
    // correctLogin совпадает с CurrentUserService userLogin, свойство .text в UITextField установлены по дефолту их корректные значения
    private let correctLogin: String = "Tigr"
    private var correctPassword: String = "qwerty"
    
    private init() {}
    
    func check(inputLogin: String, inputPassword: String) -> Bool {
        let isCorrectLoginAndPassword = correctLogin == inputLogin && correctPassword == inputPassword
        return isCorrectLoginAndPassword
    }
    
    func check(inputLogin: String, inputPassword: String, handler: @escaping (Bool) -> Void) {
        let isCorrectLoginAndPassword = correctLogin == inputLogin && correctPassword == inputPassword
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            handler(isCorrectLoginAndPassword)
        }
    }
    
    func checkLoginOnly(inputLogin: String) -> Bool {
        let isCorrectLogin = correctLogin == inputLogin
        return isCorrectLogin
    }
    
    func checkPasswordOnly(inputPassword: String) -> Bool {
        let isCorrectPassword = correctPassword == inputPassword
        return isCorrectPassword
    }
    
    func returnCorrectLogin() -> String{
        return correctLogin
    }
    
    func returnCorrectPassword() -> String{
        return correctPassword
    }
    
    func setNewPassword(newPassword: String){
        self.correctPassword = newPassword
    }
}
