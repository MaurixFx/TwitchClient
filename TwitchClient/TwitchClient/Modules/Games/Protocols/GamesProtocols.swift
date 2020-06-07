//
//  GamesProtocols.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

protocol GamesServiceProtocol {
    func fetchTopGames(url: String, completionHandler: @escaping (Result<TopGamesResponse, ResponseAlert>) -> Void)
}

protocol GamesPresenterProtocol {
    func loadTopGames()
}

protocol GamesViewProtocol: AnyObject {
    var topGames: [TopGames] { get set }
    func displayTopGames(games: [TopGames])
    func displayAlert(message: String)
}
