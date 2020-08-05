//
//  FetchCityImageService.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Common

public typealias FetchCityImageServiceCompletion = (Result<String,CapitalsError>) -> Void

public protocol FetchCityImageService {
    func call(cityName: String, completion: @escaping FetchCityImageServiceCompletion)
}
