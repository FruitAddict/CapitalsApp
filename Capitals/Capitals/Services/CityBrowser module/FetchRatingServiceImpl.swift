//
//  FetchRatingServiceImpl.swift
//  Capitals
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Networking
import CityBrowser

class FetchRatingServiceImpl: FetchRatingService {
 
    private let endpoint = "/FruitAddict/3205cc2c80ee7b35d0fe6782be986f31/raw/cfe0d7643178837bac2e2f9405c12d7f2891395a/rating.json"
    let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func call(cityName: String, completion: @escaping FetchRatingServiceCompletion) {
        
        let endpointDefiniton = CallableEndoint(endpoint: endpoint, type: .get(args: [:]))
        
        networkingService.request(with: endpointDefiniton, completion: completion)
    }
}
