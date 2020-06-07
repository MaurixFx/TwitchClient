//
//  GamesSeed.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
@testable import TwitchClient

class GamesSeed {

    static func getDataFromJSON(expectValid: Bool) -> Data? {
        var data: Data?
        let bundle = Bundle(for: GamesSeed.self)
        if let path = bundle.path(forResource: expectValid ? "top_games" : "top_games_wrong", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            
            do {
                data = try Data(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
            } catch {
                return nil
            }
        }
        return data
    }
    
    static func getTopGamesResponse(data: Data?) throws -> TopGamesResponse? {
         guard let data = getDataFromJSON(expectValid: true) else { return nil }
        
        do {
            return try JSONDecoder().decode(TopGamesResponse.self, from: data)
        } catch {
            throw ResponseAlert.invalidData
        }
    }
    
}
