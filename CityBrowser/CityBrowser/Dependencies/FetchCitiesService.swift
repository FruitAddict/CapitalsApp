//
//  FetchCitiesService.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import Common

public typealias FetchCitiesServiceCompletion = (Result<[City],CapitalsError>) -> Void

public protocol FetchCitiesService {
    func call(completion: @escaping FetchCitiesServiceCompletion)
}
