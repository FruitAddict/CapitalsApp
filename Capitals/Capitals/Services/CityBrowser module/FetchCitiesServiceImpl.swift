//
//  FetchCitiesServiceImpl.swift
//  Capitals
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Networking
import CityBrowser

class FetchCitiesServiceImpl: FetchCitiesService {
    
    private let endpoint = "/FruitAddict/55ac6d021b8c9e4a9cf59c934661d7bb/raw/da9d43a22cba17abf0330584fb19a188f02f63cf/cities.json"
    
    let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func call(completion: @escaping FetchCitiesServiceCompletion) {
        
        let endpointDefiniton = CallableEndoint(endpoint: endpoint, type: .get(args: [:]))
        
        networkingService.request(with: endpointDefiniton, completion: completion)
    }
}
