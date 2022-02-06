//
//  GamesConfigurator.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 24-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

final class GamesConfigurator {
    
    func configure(viewController: GamesViewController) {
        let gamesService = GamesService(apiClient: ApiClient())
        let presenter = GamesPresenter(controller: viewController, gamesService: gamesService)
        viewController.presenter = presenter
    }
    
}
