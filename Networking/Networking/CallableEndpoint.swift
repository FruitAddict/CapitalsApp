//
//  CallableEndpoint.swift
//  Networking
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

//MARK: - Endpoint definition
public struct CallableEndoint {
    
    public enum RequestType {
        case get(args: [String: String])
    }
    
    //MARK: - Properties
    var endpoint: String
    var type: RequestType
    
    public init(endpoint: String, type: RequestType) {
        self.endpoint = endpoint
        self.type = type
    }
}

//MARK: - Turning endoint definition into URLRequest
public extension CallableEndoint {
    
    func makeRequest(baseURL: String) -> URLRequest? {
        switch type {
        case .get(let args):
            let request = makeGetRequest(baseURL: baseURL, args: args)
            return request
        }
    }
    
    private func makeGetRequest(baseURL: String,args: [String: String]) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = endpoint
        components.queryItems = args.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard
            let url = components.url
        else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
