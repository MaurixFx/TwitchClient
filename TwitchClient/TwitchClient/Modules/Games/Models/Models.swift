//
//  Models.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

struct TopGamesResponse: Codable {
    let total: Int
    let top: [TopGames]
    
    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case top
    }
}

struct TopGames: Codable {
    let game: Games
    let viewers: Int
    let channels: Int
}

struct Games: Codable {
    let name: String
    let id: Int
    let image: GameImage
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
        case image = "box"
    }
}

struct GameImage: Codable {
    var large: String
    var medium: String
}
