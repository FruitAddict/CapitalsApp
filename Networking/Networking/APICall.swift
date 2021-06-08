//
//  Networking.swift
//  Networking
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Common

public protocol NetworkCancellable {
    func cancel()
}

extension URLSessionDataTask: NetworkCancellable {}

final class APICall<Response: Codable> {
    
    typealias Completion = (Result<Response,CapitalsError>) -> Void
    
    //MARK: - Properties
    private let session: URLSession
        
    private let logger: Logger
    
    //MARK: - Init & Configuration
    init(session: URLSession = .shared, logger: Logger = DefaultLogger.shared) {
        self.session = session
        self.logger = logger
    }
    
    //MARK: - Calls
    func call(baseURL: String, endpoint: CallableEndoint, completion: @escaping Completion) -> NetworkCancellable? {
        guard
            let request = endpoint.makeRequest(baseURL: baseURL)
        else {
            logger.error("Failed to make URL Request for endpoint: \(endpoint.endpoint)")
            completion(.failure(.requestParseError))
            return nil
        }
        
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                self.logger.error("Networking error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.other(localizedDescription: error.localizedDescription)))
                }
                return
            }
            
            guard
                let data = data
            else {
                completion(.failure(.jsonParseError))
                return
            }

            let decoder = JSONDecoder()
            let response: Response
            
            do {
                response = try decoder.decode(Response.self, from: data)
            } catch {
                DispatchQueue.main.async {
                    self.logger.error("Failed to decode response with error: \(error.localizedDescription)")
                    completion(.failure(.other(localizedDescription: error.localizedDescription)))
                }
                return
            }
       
            DispatchQueue.main.async {
                self.logger.success("Data tak completed: \(endpoint.endpoint).")
                completion(.success(response))
            }
        }
        
        task.resume()
        
        return task
    }
}
