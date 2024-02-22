//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Виталий Мишин on 07.09.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: UIImageView = {
        let photos = UIImageView()
        photos.translatesAutoresizingMaskIntoConstraints = false
        return photos
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Ups")
    }
    
    private func setupUI(){
        self.contentView.addSubview(photo)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func update(model: UIImage) {
        self.photo.image = model
    }
}

