//
//  FetchRatingService.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Common

public typealias FetchRatingServiceCompletion = (Result<CityRating,CapitalsError>) -> Void

public protocol FetchRatingService {
    func call(cityName: String, completion: @escaping FetchRatingServiceCompletion)
}

