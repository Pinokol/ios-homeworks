//
//  RealmService.swift
//  Chucknorris
//
//  Created by Виталий Мишин on 12.03.2024.
//

import RealmSwift

final class AllJoke {
    static let shared = AllJoke()
    //Создаём объект Realm, который будет представлять БД
    let realm = try? Realm()
    
    private init() {}
    
    func addCategories(_ categoriesJokes: [CategoriesJokesRealm]) {
        write {
            realm?.add(categoriesJokes)
        }
    }
    
    func addCategory(_ categoryJokes: CategoriesJokesRealm) {
        write {
            realm?.add(categoryJokes)
        }
    }
    
    func save(_ joke: JokeRealm, to categoryJokes: CategoriesJokesRealm) {
        write {
            categoryJokes.jokes.append(joke)
        }
    }
    
    func deleteAll() {
        write {
            realm?.deleteAll()
            print("delete")
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm?.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
