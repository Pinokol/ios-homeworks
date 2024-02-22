//
//  Checker.swift
//  Navigation
//
//  Created by Виталий Мишин on 07.11.2023.
//

//import Foundation
//
//final class Checker {
//    
//    static let shared = Checker()
//    // correctLogin совпадает с CurrentUserService userLogin, свойство .text в UITextField установлены по дефолту их корректные значения
//    private let correctLogin: String = "Tigr"
//    private var correctPassword: String = "qwerty"
//    
//    private init() {}
//    
//    func check(inputLogin: String, inputPassword: String) -> Bool {
//        let isCorrectLoginAndPassword = correctLogin == inputLogin && correctPassword == inputPassword
//        return isCorrectLoginAndPassword
//    }
//    
//    func check(inputLogin: String, inputPassword: String, handler: @escaping (Bool) -> Void) {
//        let isCorrectLoginAndPassword = correctLogin == inputLogin && correctPassword == inputPassword
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            handler(isCorrectLoginAndPassword)
//        }
//    }
//    
//    func checkLoginOnly(inputLogin: String) -> Bool {
//        let isCorrectLogin = correctLogin == inputLogin
//        return isCorrectLogin
//    }
//    
//    func checkPasswordOnly(inputPassword: String) -> Bool {
//        let isCorrectPassword = correctPassword == inputPassword
//        return isCorrectPassword
//    }
//    
//    func returnCorrectLogin() -> String{
//        return correctLogin
//    }
//    
//    func returnCorrectPassword() -> String{
//        return correctPassword
//    }
//    
//    func setNewPassword(newPassword: String){
//        self.correctPassword = newPassword
//    }
//}

import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String) async throws -> User?
    func signUp(email: String, password: String) async throws -> User?
}

final class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String) async throws -> User? {
        let user = CurrentUserService().authorization()
        do {
            let currentUser = try await Auth.auth().signIn(withEmail: email, password: password)
            user?.userFullName = currentUser.user.email ?? "co@co.co"
            user?.userStatus = currentUser.user.uid
        } catch {
            throw error
        }
        return user
    }
    
    func signUp(email: String, password: String) async throws -> User? {
        let user = CurrentUserService().authorization()
        do {
            let createdUser = try await Auth.auth().createUser(withEmail: email, password: password)
            user?.userFullName = createdUser.user.email ?? "co@co.co"
            user?.userStatus = createdUser.user.uid
        } catch {
            throw error
        }
        return user
    }
    
}
