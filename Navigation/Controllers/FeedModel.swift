//
//  FeedModel.swift
//  Navigation
//
//  Created by Виталий Мишин on 20.11.2023.
//

import Foundation

class FeedModel {
    
    private var secretWord = "Amur"
    let notificationCenter = NotificationCenter.default
    
    init() {}
    
    var onShowNextView: (() -> Void)?
        
        lazy var onTapShowNextView: () -> Void = { [weak self] in
            self?.onShowNextView?()
        }
    
    func check(inputSecretWord word: String) {
            let message = "Word is " + (word == secretWord ? "correct" : "not correct")
            let name = NSNotification.Name(rawValue: message)
            let notification = Notification(name: name, object: nil, userInfo: nil)
            notificationCenter.post(notification)
        }
    
    func returnCorrectSecretWord() -> String{
        return secretWord
    }
}
