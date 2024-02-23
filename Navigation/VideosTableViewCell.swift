//
//  VideosTableViewCell.swift
//  Navigation
//
//  Created by Виталий Мишин on 18.01.2024.
//

import UIKit

class VideosTableViewCell: UITableViewCell {
    
    let viewModel = MediaModel()
    
    private let videoLabel: UILabel = {
        let videoLabel = UILabel()
        videoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        videoLabel.textColor = .white
        videoLabel.text = "Видео"
        videoLabel.translatesAutoresizingMaskIntoConstraints = false
        return videoLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemGreen
        contentView.addSubview(videoLabel)
    }
    
    public func update(model: String) {
        self.videoLabel.text = model
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            videoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
