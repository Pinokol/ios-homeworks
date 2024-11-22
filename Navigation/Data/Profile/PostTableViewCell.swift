//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Виталий Мишин on 24.08.2023.
//
import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    private var viewCounter = 0
    var favorite: Bool = false
    let favoriteService: FavoriteService
    var favoriteBase = [FavoritesPostData]()
    
    var postAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .primaryText
        label.numberOfLines = 2
        return label
    }()
    
    var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .backgroung
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .primaryText
        label.numberOfLines = 0
        return label
    }()
    
    var postLikes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryText
        return label
    }()
    
    var postViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryText
        return label
    }()
    
    var favoriteChecker: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "heart.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .red
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        self.favoriteService = FavoriteService(coreDataService: CoreDataService.shared)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postAuthor,
                                postImage,
                                postDescription,
                                postLikes,
                                postViews,
                                favoriteChecker)
        
        setupConstraints()
        setRecognizer()
        self.selectionStyle = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("error".localized)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacing16),
            postAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing16),
            postAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing16),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 0.75),
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: .spacing16),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: .spacing16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing16),
            
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: .spacing16),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing16),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacing16),
            
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: .spacing16),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing16),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacing16),
            
            favoriteChecker.heightAnchor.constraint(equalToConstant: .height30),
            favoriteChecker.widthAnchor.constraint(equalToConstant: .spacing30),
            favoriteChecker.rightAnchor.constraint(equalTo: postAuthor.rightAnchor, constant: -.spacing10),
            favoriteChecker.topAnchor.constraint(equalTo: postAuthor.topAnchor, constant: 0)
        ])
    }
    
    func update(model: Post) {
        postAuthor.text = model.author
        postDescription.text = model.description
        postImage.image = model.image
        postLikes.text = "likes".localized + ": \(model.likes)"
        postViews.text = "views".localized + ": \(model.views)"
        viewCounter = model.views
        
        favoriteChecker.image = UIImage(systemName: model.favorite ? "heart.fill" : "heart")
        favorite = model.favorite
    }
    
    private func setRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
        recognizer.numberOfTapsRequired = 2
        addGestureRecognizer(recognizer)
    }
    
    @objc private func tapPressed() {
        let description = postDescription.text
        let postsFilter = postExamples.filter {
            $0.description == description
        }
        if let resultPost = postsFilter.first, favorite == false {
            if let rowIndex = postExamples.firstIndex(where: {$0.description == resultPost.description}) {
                postExamples[rowIndex].favorite = true
            } else {
                if let rowIndex = postExamples.firstIndex(where: {$0.description == resultPost.description}) {
                    postExamples[rowIndex].favorite = false
                }
            }
            favoriteService.createItem(with: resultPost) { [weak self] newCreateItem in
                self?.favoriteBase = newCreateItem
            }
        }
    }
    
    func incrementPostViewsCounter() {
        viewCounter += 1
        postViews.text = "views".localized + ": \(viewCounter)"
    }
}

