//
//  Error.swift
//  Navigation
//
//  Created by Виталий Мишин on 10.01.2024.
//

import Foundation

enum LoginError: Error {
    case userNotFound
    case wrongPassword
    case userNotFoundAndWrongPassword
    case tooStrongPassword
}
