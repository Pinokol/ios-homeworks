//
//  Post.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.07.2023.
//

import Foundation


struct PostFeed{
    var title: String
}

struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

let postExamples: [Post] = [
    Post(author: "Брюс Ли",
         description: "Пустые карманы никогда не помешают нам стать теми, кем мы хотим быть. Помешать этому могут только пустые сердца.",
         image: "post1",
         likes: 20,
         views: 22),
    Post(author: "Джим Керри",
         description: "Погода не отстой. Понедельник не отстой. Твоя работа не отстой. Отстой - это твоё негативное мышление, отсутствие самооценки и любви к себе.",
         image: "post2",
         likes: 10,
         views: 22),
    Post(author: "Джеки Чан",
         description: "Хорошие ноги рано или поздно станут спотыкаться, гордая спина - согнётся, волосы - посидеют, красивое лицо - покроется морщинами и только доброе сердце - подобно солнцу никогда не изменится и будет нести теплоту.",
         image: "post3",
         likes: 30,
         views: 33),
    Post(author: "Киану Ривс",
         description: "Не жди когда уйдут. Люби сегодня.",
         image: "post4",
         likes: 40,
         views: 44)
]
