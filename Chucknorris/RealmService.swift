//
//  RealmService.swift
//  Chucknorris
//
//  Created by Виталий Мишин on 12.03.2024.
//
import Foundation
import RealmSwift

final class AllJoke {
    static let shared = AllJoke()
    //Создаём объект Realm, который будет представлять БД
    let realm: Realm
    
    private init() {
        if let url = Realm.Configuration.defaultConfiguration.fileURL {
            try? FileManager.default.removeItem(at: url)
        }
        
        func getKey() -> Data {
            let keychainIdentifier = "io.Realm.EncryptionExampleKey"
            let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            //Создаю запрос к связке ключей на извлечение сохранённого ключа
            var query: [NSString: AnyObject] = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
                kSecAttrKeySizeInBits: 512 as AnyObject,
                kSecReturnData: true as AnyObject
            ]
            var dataTypeRef: AnyObject?
            // Пытаюсь извлечь сохранённый ключ
            var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
            if status == errSecSuccess {
                // Если ключ извлёкся, возвращаю его
                return dataTypeRef as! Data
            }
            // Если ключ не извлёкся, генерирую новый ключ
            var key = Data(count: 64)
            key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
                let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
                assert(result == 0, "Failed to get random bytes")
            })
            query = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
                kSecAttrKeySizeInBits: 512 as AnyObject,
                kSecValueData: key as AnyObject
            ]
            // сохраняю его
            status = SecItemAdd(query as CFDictionary, nil)
            assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
            // и возвращаю его из функции
            return key
        }
        
        let config = Realm.Configuration(encryptionKey: getKey(), schemaVersion: 1)
        
        do {
            realm = try Realm(configuration: config)
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
    }
    
    func addCategories(_ categoriesJokes: [CategoriesJokesRealm]) {
        write {
            realm.add(categoriesJokes)
        }
    }
    
    func addCategory(_ categoryJokes: CategoriesJokesRealm) {
        write {
            realm.add(categoryJokes)
        }
    }
    
    func save(_ joke: JokeRealm, to categoryJokes: CategoriesJokesRealm) {
        write {
            categoryJokes.jokes.append(joke)
        }
    }
    
    func deleteAll() {
        write {
            realm.deleteAll()
            print("delete")
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
