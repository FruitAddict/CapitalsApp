//
//  FetchRecentVisitorsServiceImpl.swift
//  Capitals
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Networking
import CityBrowser

class FetchRecentVisitorsServiceImpl: FetchRecentVisitorsService {
    
    private let endpoint = "/FruitAddict/e28e9891bc1430767c3eab5132d2ac77/raw/0246db8064e9065e7a1862b7365dd26574f02395/visitors.json"
    let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func call(cityName: String, completion: @escaping FetchRecentVisitorsServiceCompletion) {
        
        let endpointDefiniton = CallableEndoint(endpoint: endpoint, type: .get(args: [:]))
        
        networkingService.request(with: endpointDefiniton, completion: completion)
    }
    
}
