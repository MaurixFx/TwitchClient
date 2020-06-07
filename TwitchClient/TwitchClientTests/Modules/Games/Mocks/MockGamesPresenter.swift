//
//  MockGamesPresenter.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
@testable import TwitchClient

class MockGamesPresenter: GamesPresenterProtocol {

    var loadTopGamesIsCalled: Bool = false
    var loadTopGamesCounter: Int = 0
    
    func loadTopGames() {
        loadTopGamesCounter += 1
        loadTopGamesIsCalled = true
    }
    
}
