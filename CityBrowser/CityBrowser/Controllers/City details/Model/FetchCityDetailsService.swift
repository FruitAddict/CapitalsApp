//
//  FetchCityDetailsService.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Common

typealias FetchCityDetailsServiceCompletion = (Result<CityDetails,CapitalsError>) -> Void

protocol FetchCityDetailsService {
    func fetchCityDetails(forCity city: String, completion: @escaping FetchCityDetailsServiceCompletion)
}
