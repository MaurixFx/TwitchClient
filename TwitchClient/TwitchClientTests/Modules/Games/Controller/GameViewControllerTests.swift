//
//  GameViewControllerTests.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 24-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import XCTest
@testable import TwitchClient

class GameViewControllerTests: XCTestCase {
    
    var window: UIWindow?
    var sut: GamesViewController!
    var mockGamesPresenter: MockGamesPresenter!
    var mockCollectionView: MockCollectionView!

    override func setUpWithError() throws {
        super.setUp()
        
        window = UIWindow()
        sut = GamesViewController()
        mockGamesPresenter = MockGamesPresenter()
        mockCollectionView = MockCollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout.init()
        )
        sut.gamesView.collectionView = mockCollectionView
        loadView()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        super.tearDown()
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        window = nil
        mockGamesPresenter = nil
        mockCollectionView = nil
        sut = nil
    }
    
    func loadView() {
        guard let window = window, let sut = sut else {
            return
        }
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    func testGamesViewController_WhenNavigationController_ShouldHaveTitle() {
 
        // Then
        XCTAssertEqual(sut.navigationItem.title, "TOP GAMES")
    }
    
    func testGamesViewController_WhenTheViewIsLoaded_ShouldHaveCollectionView() {

        // Then
        XCTAssertNotNil(sut.gamesView.collectionView, "CollectionView should be not nil after the viewDidLoad()")
    }
    
    func testGamesViewController_WhenTheViewIsLoaded_ShouldSetupCollectionViewDataSource() {
        
        // Then
        XCTAssertNotNil(mockCollectionView.dataSource, "CollectionViewDataSource should be configurated when the view is loaded")
    }
    
    func testGamesViewController_WhenTheViewIsLoaded_ShouldSetupCollectionViewDelegate() {

        // Then
        XCTAssertNotNil(mockCollectionView.delegate, "CollectionViewDataSource should be configurated when the view is loaded")
    }
    
    func testGamesViewController_WhenViewIsLoaded_ShouldAskToPresenterForLoadTopGames() {

        // Given
        sut.presenter = mockGamesPresenter

        // When
        sut.getTopGames()

        // Then
        XCTAssertTrue(mockGamesPresenter.loadTopGamesIsCalled, "The method loadTopGames() was not called in the GamesPresenter class")
        XCTAssertEqual(mockGamesPresenter.loadTopGamesCounter, 1, "The method loadTopGames() should be call just one time")
    }
    
    func testGamesViewController_WhenTopGamesListIsDisplayed_ShouldCollectionViewReloadData() {
        
        // When
        sut.displayTopGames(games: [TopGames]())
        
        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.mockCollectionView.reloadDataIsCalled, "The reload data is not called when the list of top games was displayed")
        }
        
    }
    
    func testGamesViewController_WhenHaveEmptyTopGamesArray_NumberOfItemsShouldBeZero() {
       
        // When
        sut.displayTopGames(games: [TopGames]())
        
        // Then
        let numberOfItems = self.sut.gamesView.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(numberOfItems, 0, "The number of items is 0")
    }
    
    func testGamesViewController_NumberOfSectionsShouldAlwaysBeOne() {
        
        // When
        sut.displayTopGames(games: [TopGames]())
        
        // Then
        let numberOfSections = self.sut.gamesView.collectionView.numberOfSections
        XCTAssertEqual(numberOfSections, 1, "The number of sections should be always be one")
    }
    
    func testGamesViewController_NumberOfItemsShouldBeEqualToNumberOfTopGamesToDisplay() {
        
        // Given
        let topGames = getTopGames()
        
        // When
        sut.displayTopGames(games: topGames)
        
        // Then
        let numberOfItems = self.sut.gamesView.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(numberOfItems, topGames.count, "The number of items in the collectionView should be equal to the number of TopGames")
    }
    
//    func testGamesViewController_ShouldConfigureGamesTableViewCell() {
//
//        // Given
//        let expectation = self.expectation(description: "Expected to the info in GameCollectionViewCell should be equal to the info into the list of Top Games")
//        let topGames = getTopGames()
//
//        // When
//        loadView()
//        self.sut.displayTopGames(games: topGames)
//
//        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
//
//        // Then
//        let indexPath = IndexPath(row: 0, section: 0)
//
//        DispatchQueue.main.async {
//
//            self.sut.displayTopGames(games: topGames)
//
//            let cells = self.sut.gamesView.collectionView.visibleCells as! [GamesCollectionViewCell]
//            XCTAssertEqual(cells.count, topGames.count, "Cells count should match array.count")
//            expectation.fulfill()
//            //                for I in 0...cells.count - 1 {
//            //                    let cell = cells[I]
//            //                    XCTAssertEqual(cell.photoImageView.image, UIImage(named: fakeImagesName[I]), "Image should be matching")
//            //                }}
//
//
//
//            //                let cells = self.sut.gamesView.collectionView.visibleCells
//            //                if cells.count > 0 {
//            //                    guard let cell = cells[0] as? GamesCollectionViewCell else {
//            //                        XCTFail("The cell doesn't configured")
//            //                        return
//            //                    }
//            //                }
//            //
//            //                guard let cell2 = self.sut.gamesView.collectionView.cellForItem(at: indexPath) as? GamesCollectionViewCell else {
//            //                    XCTFail("The cell doesn't configured")
//            //                    return
//            //                }
//
//            //                let name = topGames[0].game.name
//            //                let nameInCell = cell.nameLabel.text
//            //                XCTAssertEqual(name, nameInCell, "the name of the game should be equal to the text in the nameLabel of the GamesCollectionViewCell")
//        }
//
//        self.wait(for: [expectation], timeout: 30)
//    }
    
    private func getTopGames() -> [TopGames] {
        
        var games: [TopGames] = []
        
        do {
            guard let topGamesResponse = try GamesSeed.getTopGamesResponse(data: GamesSeed.getDataFromJSON(expectValid: true)) else {
                return games
            }
            
            games = topGamesResponse.top
        } catch {
            XCTFail("Unexpected error in the display process in the GamesViewController class")
        }
        
        return games
    }
    
}
