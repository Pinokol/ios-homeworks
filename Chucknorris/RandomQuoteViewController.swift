//
//  RandomQuoteViewController.swift
//  Chucknorris
//
//  Created by Виталий Мишин on 12.03.2024.
//

import UIKit
import RealmSwift

final class RandomQuoteViewController: UIViewController {
    
    let jokesService = JokeFromNetwork()
    private var categoriesJokes: Results<CategoriesJokesRealm>!
    
    private lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .systemGreen
        label.alpha = 0.7
        label.numberOfLines = 0
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.text = ""
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Загрузка случайной шутки", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(addJoke), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(showCategory), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.isHidden = true
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete All", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(deleteAllJoke), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesJokes = AllJoke.shared.realm?.objects(CategoriesJokesRealm.self)
        setupUI()
        setupConstraints()
        setCategory()
        setRandomJokeForFirstStart()
#if DEBUG
        deleteButton.isHidden = false
        showButton.isHidden = false
#endif
    }
    
    private func setupUI(){
        view.addSubviews(downloadButton, jokeLabel, showButton, deleteButton)
        view.backgroundColor = .systemBackground
    }
    
    @objc private func addJoke() {
        self.downloadButton.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.downloadButton.isUserInteractionEnabled = true
        }
        jokesService.downloadJoke(categoryName: categoriesJokes.randomElement()?.nameOfCategory) { [weak self] (joke) in
            guard let joke = joke else {return}
            let category = joke.categories[0]
            let jokeIDFromRequest = joke.id
            var isJokeInRealm = false
            DispatchQueue.main.async {
                if AllJoke.shared.realm?.objects(JokeRealm.self).filter("id == %@", jokeIDFromRequest).first != nil {
                    isJokeInRealm = true
                } else {
                    isJokeInRealm = false
                }
                let categoryJoke = AllJoke.shared.realm?.objects(CategoriesJokesRealm.self).filter("nameOfCategory == %@", category)
                guard let categoryJoke2 = categoryJoke?.toArray(type: CategoriesJokesRealm.self) else {return}
                self?.jokeLabel.text = "Цитата:\n\(joke.value)"
                if !isJokeInRealm {
                    let oneNewJoke = JokeRealm()
                    oneNewJoke.id = joke.id
                    oneNewJoke.value = joke.value
                    oneNewJoke.createdDate = Date().formated()
                    oneNewJoke.category = categoryJoke2[0]
                    AllJoke.shared.save(oneNewJoke, to: categoryJoke2[0])
                }
            }
        }
    }
    
    private func setCategory() {
        if categoriesJokes.isEmpty {
            jokesService.request(url: JokeFromNetworkURL.categories.url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let freashCategories):
                        for category in freashCategories {
                            let oneNewCategory = CategoriesJokesRealm()
                            oneNewCategory.nameOfCategory = category
                            AllJoke.shared.addCategory(oneNewCategory)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    private func setRandomJokeForFirstStart(){
        getRandomJoke { [ weak self] result in
            switch result {
            case .success(let joke):
                DispatchQueue.main.async {
                    self?.jokeLabel.text = "Цитата:\n\(joke.value)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getRandomJoke(completion: @escaping (Result<JokeCodable,NetworkError>) -> Void){
        guard let url = JokeFromNetworkURL.random.url else {return}
        jokesService.fetchData(request: URLRequest(url: url), completion: completion)
    }
    
    @objc private func showCategory() {
        DispatchQueue.main.async {
            let categoryJoke = AllJoke.shared.realm?.objects(CategoriesJokesRealm.self).filter("nameOfCategory == %@", self.categoriesJokes.randomElement()?.nameOfCategory ?? "animal").first
            print("func showCategory: " + (categoryJoke?.nameOfCategory ?? "") as String)
            if let categoryJoke = categoryJoke {
                for joke in categoryJoke.jokes {
                    print("\(joke.id), \(joke.value)")
                }
            }
        }
    }
    
    @objc private func deleteAllJoke() {
        DispatchQueue.main.async {
            AllJoke.shared.deleteAll()
            self.setCategory()
            self.categoriesJokes = AllJoke.shared.realm?.objects(CategoriesJokesRealm.self)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            jokeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacing16),
            jokeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing16),
            jokeLabel.heightAnchor.constraint(equalToConstant: .height300),
            jokeLabel.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -.spacing16),
            
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing16),
            downloadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: .spacing65),
            downloadButton.heightAnchor.constraint(equalToConstant: .height50),
            
            showButton.heightAnchor.constraint(equalToConstant: .height50),
            showButton.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: .spacing15),
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing16),
            
            deleteButton.heightAnchor.constraint(equalToConstant: .height50),
            deleteButton.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: .spacing15),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacing16)
            
        ])
    }
}

