//
//  NetworkService.swift
//  Navigation
//
//  Created by Виталий Мишин on 28.01.2024.
//

import Foundation

struct NetworkService {
    
    static func request(url: URL?) {
        guard let url = url else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: url) {data, response, error in
            
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Код ответа: \(httpResponse.statusCode)")
                print("Заголовки: \(httpResponse.allHeaderFields)")
            }
            
            guard let data else {
                print("Нет данных!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print("Данные получены: \(json)")
            } catch {
                print("Ошибка обработки JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    static func request(url: URL?, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = url else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: url) {data, response, error in
            
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                completion(.failure(.unowned))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        do {
                            guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                            guard let title = jsonDictionary["title"] as? String else { return }
                            completion(.success(title))
                        } catch {
                            print("Ошибка обработки JSON: \(error.localizedDescription)")
                            completion(.failure(.decodeError))
                        }
                    }
                case 404:
                    completion(.failure(.notFound))
                default:
                    break
                }
            }
        }
        task.resume()
    }
    
    static func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            return df
        }()
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.unowned))
            }
            
            if let response = response as? HTTPURLResponse {
                
                print("Status code: \(response.statusCode)")
                
                switch response.statusCode {
                case 200:
                    if let data = data {
                        
                        if let string = String(data: data, encoding: .utf8) {
                            print("RAW responce: \(string)")
                        }
                        
                        let decoder = JSONDecoder()
                        
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        do {
                            let value = try decoder.decode(T.self, from: data)
                            completion(.success(value))
                        } catch {
                            completion(.failure(.decodeError))
                        }
                    }
                    
                case 404:
                    completion(.failure(.notFound))
                case 500:
                    completion(.failure(.serverError))
                default:
                    assertionFailure("unowned status code = \(response.statusCode)")
                    completion(.failure(.unowned))
                }
            }
        }
        dataTask.resume()
    }
    
    func fetchData<T: Decodable>(request: URLRequest, as type: T.Type) async -> Result<T, NetworkError>{
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(df)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponce = response as? HTTPURLResponse else { return .failure(.serverError)}
            let code = httpResponce.statusCode
            
            
            if code >= 200 && code < 300 {
                let result = try decoder.decode(type.self, from: data)
                return .success(result)
            }
            return .failure(.serverError)
        } catch {
            print(error.localizedDescription)
            return .failure(.badRequest)
        }
        
    }
}
