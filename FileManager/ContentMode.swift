//
//  ContentMode.swift
//  FileManager
//
//  Created by Виталий Мишин on 25.02.2024.
//

import Foundation

enum TypeOfFile {
    case folder
    case file
}

struct Content {
    let name: String
    let type: TypeOfFile
    let size: String
}
