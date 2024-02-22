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
    
    var postAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    var postLikes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var postViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postAuthor, postImage, postDescription, postLikes, postViews)
        setupConstraints()
        self.selectionStyle = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
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
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacing16)
        ])
    }
    
    func update(model: Post) {
        postAuthor.text = model.author
        postDescription.text = model.description
        postImage.image = UIImage(named: model.image)
        postLikes.text = "Likes: \(model.likes)"
        postViews.text = "Views: \(model.views)"
    }
    
    func incrementPostViewsCounter() {
        viewCounter += 1
        postViews.text = "Views: \(viewCounter)"
    }
}

