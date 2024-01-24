//
//  Error.swift
//  Navigation
//
//  Created by Виталий Мишин on 10.01.2024.
//

import Foundation

enum LoginError: String, Error {
    case userNotFound = "Неправильно введен логин"
    case wrongPassword // by default equal "wrongPassword"
    case userNotFoundAndWrongPassword
    case tooStrongPassword
}

enum mediaError: Error {
    case musicError
}
