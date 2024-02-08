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

enum NetworkError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case decodeError = 1000
    case serverError = 500
    case unowned = 2000
}
