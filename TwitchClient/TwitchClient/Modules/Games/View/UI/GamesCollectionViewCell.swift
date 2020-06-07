//
//  GamesTableViewCell.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 25-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

final class GamesCollectionViewCell: UICollectionViewCell {
    
    // MARK: Create UILabels
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    let countViewersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .red
        return label
    }()
    
    let countChannelsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .blue
        return label
    }()
    
    // MARK: Create UIImageView
    let gameImageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup Cell
    fileprivate func setupCell() {
        backgroundColor = .clear
        addComponentsInCell()
        setupConstraints()
    }
    
    fileprivate func addComponentsInCell() {
        addSubview(gameImageView)
        addSubview(nameLabel)
        addSubview(countViewersLabel)
        addSubview(countChannelsLabel)
    }
    
    fileprivate func setupConstraints() {
        
        gameImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            paddingTop: 12,
            paddingLeft: 12,
            paddingBottom: 12,
            width: frame.width * 0.30
        )
        
        nameLabel.anchor(
            top: gameImageView.topAnchor,
            left: gameImageView.rightAnchor,
            right: rightAnchor,
            paddingTop: 20,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        countViewersLabel.anchor(
            top: nameLabel.bottomAnchor,
            left: nameLabel.leftAnchor,
            right: nameLabel.rightAnchor,
            paddingTop: 10
        )
        
        countChannelsLabel.anchor(
            top: countViewersLabel.bottomAnchor,
            left: countViewersLabel.leftAnchor,
            right: countViewersLabel.rightAnchor,
            paddingTop: 10
        )
    }
    
    // MARK: Display Info
    func displayGame(topGame: TopGames) {
        guard let url = URL(string: topGame.game.image.large) else { return }
        gameImageView.loadImageWithUrl(url)
        nameLabel.text = topGame.game.name
        countViewersLabel.text = "\(topGame.viewers) Viewers"
        countChannelsLabel.text = "\(topGame.channels) Channels"
    }
    
}
