//
//  Checker.swift
//  Navigation
//
//  Created by Виталий Мишин on 07.11.2023.
//

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
            user?.userFullName = currentUser.user.email ?? "test@test.test"
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
            user?.userFullName = createdUser.user.email ?? "test@test.test"
            user?.userStatus = createdUser.user.uid
        } catch {
            throw error
        }
        return user
    }
    
}
