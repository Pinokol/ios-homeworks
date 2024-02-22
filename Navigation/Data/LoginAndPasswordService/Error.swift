//
//  Error.swift
//  Navigation
//
//  Created by Виталий Мишин on 10.01.2024.
//

import Foundation

enum LoginError: String, Error {
    case userNotFound = "Такой пользователь не существует"
    case wrongPassword = "Неправильно введен пароль"
    case userNotFoundAndWrongPassword = "Неправильно введен логин и пароль"
    case tooStrongPassword = "Пароль слижком сложный и долго подбирать"
    case suchUserAlreadyExists = "Такой пользователь уже зарегистрирован"
    case authorized = "Успешно зарегистрирован новый пользователь"
    case successful = "Успешный вход"
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
