//
//  GamesViewController.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 24-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

final class GamesViewController: UIViewController, GamesViewProtocol {
    
    // MARK: - Create GamesView
    lazy var gamesView: GamesView = {
        return GamesView(frame: UIScreen.main.bounds)
    }()
    
    // MARK: Properties
    var topGames: [TopGames] = []
    var presenter: GamesPresenterProtocol?
    
    // MARK: - Init
    init(gamesConfigurator: GamesConfigurator = GamesConfigurator()) {
        super.init(nibName: nil, bundle: nil)
        gamesConfigurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        GamesConfigurator().configure(viewController: self)
    }
    
    override func loadView() {
        super.loadView()
        view = gamesView
        
        gamesView.collectionView.dataSource = self
        gamesView.collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "TOP GAMES"
    }

    // MARK: - Actions
    func getTopGames() {
        presenter?.loadTopGames()
    }
    
    func displayTopGames(games: [TopGames]) {
        topGames = games
        DispatchQueue.main.async {
            self.gamesView.collectionView.reloadData()
        }
    }
    
    func displayAlert(message: String) {
        
    }
    
}

// MARK: - Extension UICollectionView
extension GamesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesKeys.cell, for: indexPath) as! GamesCollectionViewCell
        cell.displayGame(topGame: topGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 150)
    }
    
}
