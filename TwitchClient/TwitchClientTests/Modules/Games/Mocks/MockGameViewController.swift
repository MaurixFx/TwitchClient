//
//  MockGameViewController.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 24-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
@testable import TwitchClient
import XCTest

class MockGameViewController: GamesViewProtocol {
    
    var expectation: XCTestExpectation?
    var displayTopGamesIsCalled: Bool = false
    var displayTopGamesCounter: Int = 0
    var displayAlertIsCalled: Bool = false
    var displayAlertCounter: Int = 0
    var topGames: [TopGames] = []
    
    func displayTopGames(games: [TopGames]) {
        displayTopGamesCounter += 1
        displayTopGamesIsCalled = true
        topGames = games
        expectation?.fulfill()
    }
    
    func displayAlert(message: String) {
        displayAlertCounter += 1
        displayAlertIsCalled = true
        expectation?.fulfill()
    }
}
