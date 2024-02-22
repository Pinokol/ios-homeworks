//
//  Post.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.07.2023.
//

import Foundation

public struct PostFeed{
    public var title: String
    public init(title: String) {
            self.title = title
        }
}

public struct Post {
    public  let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
            self.author = author
            self.description = description
            self.image = image
            self.likes = likes
            self.views = views
        }
}

public let postExamples: [Post] = [
    Post(author: "Брюс Ли",
         description: "Пустые карманы никогда не помешают нам стать теми, кем мы хотим быть. Помешать этому могут только пустые сердца.",
         image: "post1",
         likes: 100,
         views: 250),
    Post(author: "Джим Керри",
         description: "Погода не отстой. Понедельник не отстой. Твоя работа не отстой. Отстой - это твоё негативное мышление, отсутствие самооценки и любви к себе.",
         image: "post2",
         likes: 115,
         views: 222),
    Post(author: "Джеки Чан",
         description: "Хорошие ноги рано или поздно станут спотыкаться, гордая спина - согнётся, волосы - посидеют, красивое лицо - покроется морщинами и только доброе сердце - подобно солнцу никогда не изменится и будет нести теплоту.",
         image: "post3",
         likes: 333,
         views: 500),
    Post(author: "Киану Ривс",
         description: "Не жди когда уйдут. Люби сегодня.",
         image: "post4",
         likes: 888,
         views: 1077)
]
