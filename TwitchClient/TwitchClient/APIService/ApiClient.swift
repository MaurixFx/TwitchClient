//
//  ApiManager.swift
//  TwitchClient
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class ApiClient {
    
    var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request(url: String, completionHandler: @escaping (Result<Data, ResponseAlert>) -> Void) {
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(ResponseAlert.urlNotValid))
            return
        }
    
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                print("Invalid Response")
                completionHandler(.failure(ResponseAlert.serverFail))
                return
            }
            
            switch statusCode {
            case 200..<300:
                guard let data = data else { return }
                completionHandler(.success(data))
            case 400..<500:
                completionHandler(.failure(ResponseAlert.resourceNotFound))
            case 500..<600:
                completionHandler(.failure(ResponseAlert.serverFail))
            default:
                break
            }
        }
        task.resume()
    }
    
    
}
