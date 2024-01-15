//
//  LoginInspectorAndFactory.swift
//  Navigation
//
//  Created by Виталий Мишин on 07.11.2023.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    
    func check(_ inputLogin: String, with inputPassword: String, handler: @escaping (Bool) -> Void)
    //без задержки
    func check(inputLogin: String, inputPassword: String) throws -> Bool
    
    func checkLoginOnly(inputLogin: String) -> Bool
    
    func checkPasswordOnly(inputPassword: String) -> Bool
    
    func passwordSelection()
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

class LoginInspector: LoginViewControllerDelegate {
    
    func checkLoginOnly(inputLogin: String) -> Bool {
        return Checker.shared.checkLoginOnly(inputLogin: inputLogin)
    }
    
    func checkPasswordOnly(inputPassword: String) -> Bool {
        return Checker.shared.checkPasswordOnly(inputPassword: inputPassword)
    }
    
    func check(_ inputLogin: String, with inputPassword: String, handler: @escaping (Bool) -> Void) {
        
        Checker.shared.check(inputLogin: inputLogin, inputPassword: inputPassword) { result in
            handler(result)
        }
    }
    
    func check(inputLogin: String, inputPassword: String) throws -> Bool {
        let isCorrectLogin = Checker.shared.checkLoginOnly(inputLogin: inputLogin)
        let isCorrectPassword = Checker.shared.checkPasswordOnly(inputPassword: inputPassword)
        if !isCorrectLogin && !isCorrectPassword {
            throw LoginError.userNotFoundAndWrongPassword
        } else {
            if !isCorrectLogin && isCorrectPassword {
                throw LoginError.userNotFound
            } else {
                if isCorrectLogin && !isCorrectPassword {
                    throw LoginError.wrongPassword
                } else{
                    return isCorrectLogin && isCorrectPassword
                }
            }
        }
    }
    
    
    private func randomPassword() -> String {
        let allowedCharacters:[String] = String().printable.map { String($0) }
        let randomInt = Int.random(in: 3..<6)
        var passWord = ""
        for _ in 0 ..< randomInt {
            guard let samSymbols = allowedCharacters.randomElement() else {return ""}
            passWord.append(samSymbols)
        }
        return passWord
    }
    
    func passwordSelection(){
        Checker.shared.setNewPassword(newPassword: randomPassword())
    }
}

struct MyLogInFactory: LoginFactory {
    
    private let inspector =  LoginInspector()
    
    func makeLoginInspector() -> LoginInspector {
        return inspector
    }
}


