//
//  GamesPresenter.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class GamesPresenter: GamesPresenterProtocol {
    
    private var gameService: GamesServiceProtocol
    private weak var controller: GamesViewProtocol?
    
    init(controller: GamesViewProtocol, gamesService: GamesServiceProtocol) {
        self.controller = controller
        self.gameService = gamesService
    }
    
    func loadTopGames() {
        
        gameService.fetchTopGames(url: Endpoints.Games.getTopGames()) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let topGamesResponse):
                self.controller?.displayTopGames(games: topGamesResponse.top)
            case .failure(let alert):
                self.controller?.displayAlert(message: alert.errorDescription)
            }
            
        }
    }
}
