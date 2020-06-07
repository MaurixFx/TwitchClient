//
//  Enum.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

enum Result<Value, ResponseAlert> {
    case success(Value)
    case failure(ResponseAlert)
}
