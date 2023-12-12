//
//  LoginInspectorAndFactory.swift
//  Navigation
//
//  Created by Виталий Мишин on 07.11.2023.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func checkLoginOnly(inputLogin: String) -> Bool {
        return Checker.shared.checkLoginOnly(inputLogin: inputLogin)
    }
    
    func checkPasswordOnly(inputPassword: String) -> Bool {
        return Checker.shared.checkPasswordOnly(inputPassword: inputPassword)
    }
    
    //без задержки
    //    func check(inputLogin: String, inputPassword: String) -> Bool {
    //        return Checker.shared.check(inputLogin: inputLogin, inputPassword: inputPassword)
    //    }
    
    func check(_ inputLogin: String, with inputPassword: String, handler: @escaping (Bool) -> Void) {
        
        Checker.shared.check(inputLogin: inputLogin, inputPassword: inputPassword) { result in
            handler(result)
        }
    }
}

struct MyLogInFactory: LoginFactory {
    
    private let inspector =  LoginInspector()
    
    func makeLoginInspector() -> LoginInspector {
        return inspector
    }
    
    
}

protocol LoginViewControllerDelegate: AnyObject {
    
    func check(_ inputLogin: String, with inputPassword: String, handler: @escaping (Bool) -> Void)
    //без задержки
    // func check(inputLogin: String, inputPassword: String) -> Bool
    
    func checkLoginOnly(inputLogin: String) -> Bool
    
    func checkPasswordOnly(inputPassword: String) -> Bool
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
