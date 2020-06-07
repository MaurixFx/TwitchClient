//
//  ResponseAlert.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

enum ResponseAlert: Error {
    
    case noInternet
    case urlNotValid
    case resourceNotFound
    case serverFail
    case invalidData
    
    var errorDescription: String {
        switch self {
        case .noInternet:
            return "You're not connected to the internet, please check your connection"
        case .urlNotValid:
            return "The Url is not valid"
        case .resourceNotFound:
            return "There's no resource you're trying to access"
        case .serverFail:
            return "We haven't been able to make a connection, try it later."
        case .invalidData:
            return "The data did not convert in the model"
        }
    }
}
