//
//  FavoriteCell.swift
//  Navigation
//
//  Created by Виталий Мишин on 20.03.2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseIdentifier = "FavoriteCell"
    
    var postAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postAuthor, postImage, postDescription)
        setupConstraints()
        self.selectionStyle = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacing16),
            postAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing16),
            postAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing16),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 0.56),
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: .spacing16),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: .spacing16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing16),
            postDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacing16),
        ])
    }
    
    func update(model: FavoritesPostData) {
        postAuthor.text = model.author
        postDescription.text = model.descriptions
        postImage.image = UIImage(named: model.image ?? "ImageTigr")
    }
    
}
