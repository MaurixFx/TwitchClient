//
//  GamesWorker.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class GamesService: GamesServiceProtocol {
    
    var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchTopGames(url: String, completionHandler: @escaping (Result<TopGamesResponse, ResponseAlert>) -> Void) {
        
        apiClient.request(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let topGamesResponse = try jsonDecoder.decode(TopGamesResponse.self, from: data)
                    completionHandler(.success(topGamesResponse))
                } catch {
                    completionHandler(.failure(.invalidData))
                }
            case .failure(let alert):
                completionHandler(.failure(alert))
            }
        }
    }
    
}
