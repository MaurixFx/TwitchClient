//
//  MockURLProtocol.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 17-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
@testable import TwitchClient

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    static var responseAlert: ResponseAlert?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        do {
            
            if let responseAlert = MockURLProtocol.responseAlert {
                self.client?.urlProtocol(self, didFailWithError: responseAlert)
            } else {
                
                guard let handler = MockURLProtocol.requestHandler else {
                    fatalError("Handler is unavailable.")
                }
                
                // 2. Call handler with received request and capture the tuple of response and data.
                let (response, data) = try handler(request)
                
                // 3. Send received response to the client.
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                
                if let data = data {
                    // 4. Send received data to the client.
                    client?.urlProtocol(self, didLoad: data)
                }
                
                // 5. Notify request has been finished.
                client?.urlProtocolDidFinishLoading(self)
            }
        } catch {
            // 6. Notify received error.
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
    
}
