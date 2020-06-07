//
//  GamesView.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 24-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class GamesView: UIView {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(GamesCollectionViewCell.self, forCellWithReuseIdentifier: GamesKeys.cell)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
}
