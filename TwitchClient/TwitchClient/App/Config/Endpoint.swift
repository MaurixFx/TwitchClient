//
//  Endpoint.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

struct Endpoints {
    
    enum Server {
        static let url = "https://api.twitch.tv/kraken/"
    }
    
    enum Games {
        static func getTopGames() -> String {
            return "\(Server.url)games/top?client_id=\(Codes.clientId)"
        }
    }
}
