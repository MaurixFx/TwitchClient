//
//  GamesWorkerTests.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import XCTest
@testable import TwitchClient

class GamesServiceTests: XCTestCase {
    
    var sut: GamesService!
    var apiClient: ApiClient!
    var apiUrl: URL!
    var fakeApiUrl: URL!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupConfigUrlSession()
        setupUrls()
        sut = GamesService(apiClient: apiClient)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiClient = nil
        sut = nil
        apiUrl = nil
        fakeApiUrl = nil
        MockURLProtocol.responseAlert = nil
        MockURLProtocol.requestHandler = nil
    }
    
    func setupConfigUrlSession() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        apiClient = ApiClient(urlSession: urlSession)
    }
    
    func setupUrls() {
        if let url = URL(string: Endpoints.Games.getTopGames()) {
            apiUrl = url
        }
        
        if let fakeUrl = URL(string: "\(Endpoints.Server.url)game/top?client_id=\(Codes.clientId)") {
            fakeApiUrl = fakeUrl
            print(fakeUrl.absoluteString)
        }
    }
    
    func testGamesService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        
        // Given
        let expectation = self.expectation(description: "Fetch successfull of Top Games From API expectation")
        
        guard let data = GamesSeed.getDataFromJSON(expectValid: true) else {
            XCTFail("Unexpected nil in Data of Top Games")
            return
        }
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // When
        sut.fetchTopGames(url: apiUrl.absoluteString) { result in
            // Then
            switch result {
            case .success(let topGamesResponse):
                XCTAssertNotNil(topGamesResponse, "topGamesResponse should be not nil in a Successfull response from the API Client")
            case .failure(let responseAlert):
                XCTAssertNil(responseAlert, "The responseAlert should be no Error in a successfull response to the API Client.")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testGamesService_WhenEmptyURLProvided_ReturnsError() {
        
        // Given
        let expectation = self.expectation(description: "An empty Url string expectation")
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiUrl, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // When
        sut.fetchTopGames(url: "") { result in
            // Then
            switch result {
            case .success(let topGamesResponse):
                XCTAssertNil(topGamesResponse, "topGamesResponse must be nil because is a Empty URL Request")
            case .failure(let responseAlert):
                XCTAssertNotNil(responseAlert, "The responseAlert must be error in a empty Url Request")
                XCTAssertEqual(responseAlert, ResponseAlert.urlNotValid, "the status of the error must be urlNotValid")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testGamesService_WhenTheURLRequestDoesNotExit_ReturnsError() {
        
        // Given
        let expectation = self.expectation(description: "An invalid Url string expectation")
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.fakeApiUrl, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // When
        sut.fetchTopGames(url: apiUrl.absoluteString) { result in
            // Then
            switch result {
            case .success(let topGamesResponse):
                XCTAssertNil(topGamesResponse, "topGamesResponse must be nil because is a Invalid URL Request")
            case .failure(let responseAlert):
                XCTAssertNotNil(responseAlert, "The responseAlert must be error in a Invalid Url Request")
                XCTAssertEqual(responseAlert, ResponseAlert.resourceNotFound, "the status of the error must be resourceNotFound")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testGamesService_WhenRequestDontHaveResponse_ReturnsError() {
        
        // Given
        let expectation = self.expectation(description: "Te request to the API failed and don't have response expectation")
        
        MockURLProtocol.responseAlert = .serverFail

        // When
        sut.fetchTopGames(url: fakeApiUrl.absoluteString) { result in
            switch result {
            case .success(let topGamesResponse):
                XCTAssertNil(topGamesResponse, "topGamesResponse must be nil because don't have response of the API")
            case .failure(let responseAlert):
                XCTAssertNotNil(responseAlert, "The responseAlert must be error in request without response")
                XCTAssertEqual(responseAlert, ResponseAlert.serverFail, "the status of the error must be serverFail")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testGameService_WhenReturnDataCanBeDecodeInTopGames_ShouldReturnSuccess() {
        
        // Given
        let expectation = self.expectation(description: "Expected succesfull Decoding of Data in Top Games")
        
        guard let data = GamesSeed.getDataFromJSON(expectValid: true) else {
            XCTFail("Unexpected nil in Data of Top Games")
            return
        }
        
        
        let totalTopGames = getTotalTopGames(data: data)
        
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // When
        sut.fetchTopGames(url: apiUrl.absoluteString) { result in
            switch result {
            case .success(let topGamesResponse):
                XCTAssertEqual(topGamesResponse.total, totalTopGames, "the total of top games is different in the return Data of the API")
            case .failure(let alert):
                XCTAssertNil(alert, "The alert should be nil for a valid Decode in Top Games")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testGameService_WhenReturnDataCanNotDecodeInTopGames_ShouldReturnError() {
        
        // Given
        let expectation = self.expectation(description: "Expected error in decoding process of data in Top Games")
        
        guard let data = GamesSeed.getDataFromJSON(expectValid: false) else {
            XCTFail("Unexpected nil in Data of Top Games")
            return
        }
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.apiUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // When
        sut.fetchTopGames(url: apiUrl.absoluteString) { result in
            switch result {
            case .success(let topGamesResponse):
                XCTAssertNil(topGamesResponse, "topGamesResponse should be nil in a invalid process of decoding Data")
            case .failure(let alert):
                XCTAssertEqual(alert, ResponseAlert.invalidData, "The error should be invalidData in a failed decoding data process")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    private func getTotalTopGames(data: Data) -> Int {
        do {
            let topResponse = try JSONDecoder().decode(TopGamesResponse.self, from: data)
            return topResponse.total
        } catch {
            XCTFail("Should be not error here because we have a valid decode for top games")
        }
        
        return 0
    }
}
    
