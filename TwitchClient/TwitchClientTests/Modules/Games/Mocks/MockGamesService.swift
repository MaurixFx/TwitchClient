//
//  MockGameWorker.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
@testable import TwitchClient

class MockGamesService: GamesServiceProtocol {
    
    var fetchTopGamesIsCalled: Bool = false
    var fetchTopGamesCounter: Int = 0
    var shouldReturnError: Bool = false
    
    func fetchTopGames(url: String, completionHandler: @escaping (Result<TopGamesResponse, ResponseAlert>) -> Void) {
        fetchTopGamesCounter += 1
        fetchTopGamesIsCalled = true
        
        if shouldReturnError {
            completionHandler(.failure(.serverFail))
        } else {
            do {
                if let topResponse = try GamesSeed.getTopGamesResponse(data: GamesSeed.getDataFromJSON(expectValid: true)) {
                    completionHandler(.success(topResponse))
                }
            } catch {
                let errorResp = error as! ResponseAlert
                completionHandler(.failure(errorResp))
            }
            
        }
    }
    
}
