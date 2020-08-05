//
//  NetworkingManager.swift
//  Networking
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Common

//MARK: - Abstract API Call
public protocol NetworkingService {
    typealias Completion<T: Codable> = (Result<T, CapitalsError>) -> Void

    @discardableResult
    func request<T: Codable>(with endpoint: CallableEndoint, completion: @escaping Completion<T>) -> NetworkCancellable?
}

//MARK: - Default implementation.
final public class DefaultNetworkingService: NetworkingService {
    
    private let baseURL: String
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    public func request<T>(with endpoint: CallableEndoint, completion: @escaping (Result<T, CapitalsError>) -> Void) -> NetworkCancellable? where T : Codable {
        
        let call = APICall<T>()
        
        return call.call(baseURL: baseURL, endpoint: endpoint, completion: completion)
    }
}
