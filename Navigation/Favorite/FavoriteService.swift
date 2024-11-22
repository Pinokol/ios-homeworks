//
//  FavoriteService.swift
//  Navigation
//
//  Created by Виталий Мишин on 20.03.2024.
//

import CoreData
import StorageService
import Foundation

protocol FavoriteServiceProtocol {
    var backgroundContext: NSManagedObjectContext { get }
}

final class FavoriteService: FavoriteServiceProtocol {
    
    private let coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
        self.fetchItems()
    }
    
    var backgroundContext: NSManagedObjectContext {
        coreDataService.backgroundContext
    }
    
    
    private (set) var favoriteItems = [FavoritesPostData]()
    
    func fetchItems() {
        coreDataService.backgroundContext.perform { [weak self] in
            guard let self else { return }
            let request = FavoritesPostData.fetchRequest()
            do {
                favoriteItems = try coreDataService.backgroundContext.fetch(request).map { $0 }
                
                
                for item in favoriteItems {
                    
                    if let rowIndex = postExamples.firstIndex(where: {Int64($0.id) == item.id}) {
                        
                        print("\(rowIndex), \(item.author ?? "")")
                        postExamples[rowIndex].favorite = true
                    }
                }
                
                print(postExamples)
                
            } catch {
                
                print(error)
                favoriteItems = []
            }
            
            updateCell()
        }
    }
    
    func createItem(with post: Post, completion: @escaping ([FavoritesPostData]) -> Void) {
        coreDataService.backgroundContext.perform { [weak self] in
            guard let self else { return }
            let newItem = FavoritesPostData(context: coreDataService.backgroundContext)
            newItem.author = post.author
            newItem.descriptions = post.description
            newItem.image = post.imageName
            newItem.id = Int64(post.id)
            newItem.isFavorite = true
            if let rowIndex = postExamples.firstIndex(where: {Int64($0.id) == newItem.id}) {
                postExamples[rowIndex].favorite = true
            }
            if coreDataService.backgroundContext.hasChanges {
                do {
                    try coreDataService.backgroundContext.save()
                    coreDataService.backgroundContext.perform { [weak self] in
                        guard let self else { return }
                        favoriteItems.insert(newItem, at: 0)
                        completion(favoriteItems)
                    }
                } catch {
                    coreDataService.backgroundContext.perform { [weak self] in
                        guard let self else { return }
                        completion(favoriteItems)
                    }
                }
            }
        }
        updateCell()
    }
    
    private func updateCell(){
        DispatchQueue.main.async {
            ProfileViewController.postTableView.reloadData()
        }
    }
    
}
