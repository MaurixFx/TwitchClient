//
//  GamesPresenterTests.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 24-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import XCTest
@testable import TwitchClient

class GamesPresenterTests: XCTestCase {
    
    var sut: GamesPresenter!
    var mockGameService: MockGamesService!
    var mockGameViewController: MockGameViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        mockGameService = MockGamesService()
        mockGameViewController = MockGameViewController()
        sut = GamesPresenter(controller: mockGameViewController, gamesService: mockGameService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        mockGameService = nil
        mockGameViewController = nil
        sut = nil
    }
    
    func testGamesPresenter_ShouldAskToFetchTopGamesToGamesService() {
        
        // When
        sut.loadTopGames()
        
        // Then
        XCTAssertTrue(mockGameService.fetchTopGamesIsCalled, "The method fetchTopGames() was not called in the GameService class")
        XCTAssertEqual(mockGameService.fetchTopGamesCounter, 1, "The method fetchTopGames() should be call just one time in the GameService class")
    }
    
    func testGamesPresenter_WhenFetchTopGamesIsSuccessfull_ShouldDisplayTopGamesInController() {
        
        // Given
        let expectation = self.expectation(description: "Expected to the displayTopGames() method to be called")
        mockGameViewController.expectation = expectation
        mockGameService.shouldReturnError = false
    
        // When
        sut.loadTopGames()
        self.wait(for: [expectation], timeout: 5)
        
        // When
        XCTAssertTrue(mockGameViewController.displayTopGamesIsCalled, "The method displayTopGames() was not called in the GameViewController class")
        XCTAssertTrue(mockGameViewController.topGames.count > 0, "the list of top games should be greater than zero in the GameViewController class for a successfull response")
        XCTAssertEqual(mockGameViewController.displayTopGamesCounter, 1, "The method displayTopGames() should be call just one time")
        
    }
    
    func testGamesPresenter_WhenFetchTopGamesFails_ShouldDisplayAlertInController() {
        
        // Given
        let expectation = self.expectation(description: "Expected to the displayAlert() method to be called")
        mockGameViewController.expectation = expectation
        mockGameService.shouldReturnError = true
        
        // When
        sut.loadTopGames()
        self.wait(for: [expectation], timeout: 2)
        
        // When
        XCTAssertTrue(mockGameViewController.displayAlertIsCalled, "The method displayAlert() was not called in the GameViewController class")
        XCTAssertEqual(mockGameViewController.displayAlertCounter, 1, "The method displayAlert() should be call just one time")
    }
    
}
