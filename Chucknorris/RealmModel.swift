//
//  RealmModel.swift
//  Chucknorris
//
//  Created by Виталий Мишин on 12.03.2024.
//

import Foundation
import RealmSwift
// Создаём классы, который будут представлять объекты в БД Realm
final class CategoriesJokesRealm: Object {
    @Persisted var nameOfCategory: String
    @Persisted var jokes = List<JokeRealm>()
}

final class JokeRealm: Object {
    @Persisted var createdDate: String
    @Persisted var id: String
    @Persisted var value: String
    @Persisted var category: CategoriesJokesRealm?
}

struct JokeStruct: Comparable {
    var categories: String = ""
    var id: String = ""
    var value: String = ""
    var createdDate: String = ""
    
    static func < (lhs: JokeStruct, rhs: JokeStruct) -> Bool {
        lhs.createdDate < rhs.createdDate
    }
}

struct CategoriesJokesStruct {
    var nameOfCategory: String = ""
    var jokes: [JokeStruct] = []
}
