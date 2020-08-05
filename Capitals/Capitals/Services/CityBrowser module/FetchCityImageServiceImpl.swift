//
//  FetchCityFlagServiceImpl.swift
//  Capitals
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Networking
import CityBrowser

class FetchCityImageServiceImpl: FetchCityImageService {
    
    private let endpoint = "/FruitAddict/25b1772caefcd8e5934653e516830797/raw/8ccbb659a4a8121790200ce91611c6b58f30c6f6/gistfile1.txt"
    let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func call(cityName: String, completion: @escaping FetchCityImageServiceCompletion) {
        
        let endpointDefiniton = CallableEndoint(endpoint: endpoint, type: .get(args: [:]))
        
        networkingService.request(with: endpointDefiniton, completion: completion)
    }
}
