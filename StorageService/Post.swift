//
//  Post.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.07.2023.
//

import Foundation
import UIKit

public struct PostFeed{
    public var title: String
    public init(title: String) {
        self.title = title
    }
}

public struct Post: Identifiable {
    public let id: Int
    public let author: String
    public let description: String
    public let image: UIImage?
    public let imageName: String
    public let likes: Int
    public let views: Int
    public var favorite: Bool
    
    public init(id: Int, author: String, description: String, image: UIImage?, imageName: String, likes: Int, views: Int, favorite: Bool) {
        self.id = id
        self.author = author
        self.description = description
        self.image = image
        self.imageName = imageName
        self.likes = likes
        self.views = views
        self.favorite = favorite
    }
}

public var postExamples: [Post] = [
    Post(
        id: 0,
        author: "Брюс Ли",
        description: "Пустые карманы никогда не помешают нам стать теми, кем мы хотим быть. Помешать этому могут только пустые сердца.",
        image: UIImage(named: "post1"),
        imageName: "post1",
        likes: 100,
        views: 250,
        favorite: false),
    Post(
        id: 1,
        author: "Джим Керри",
        description: "Погода не отстой. Понедельник не отстой. Твоя работа не отстой. Отстой - это твоё негативное мышление, отсутствие самооценки и любви к себе.",
        image: UIImage(named: "post2"),
        imageName: "post2",
        likes: 115,
        views: 222,
        favorite: false),
    Post(
        id: 2,
        author: "Джеки Чан",
        description: "Хорошие ноги рано или поздно станут спотыкаться, гордая спина - согнётся, волосы - посидеют, красивое лицо - покроется морщинами и только доброе сердце - подобно солнцу никогда не изменится и будет нести теплоту.",
        image: UIImage(named: "post3"),
        imageName: "post3",
        likes: 333,
        views: 500,
        favorite: false),
    Post(
        id: 3,
        author: "Киану Ривс",
        description: "Не жди когда уйдут. Люби сегодня.",
        image: UIImage(named: "post4"),
        imageName: "post4",
        likes: 888,
        views: 1077,
        favorite: false)
]
