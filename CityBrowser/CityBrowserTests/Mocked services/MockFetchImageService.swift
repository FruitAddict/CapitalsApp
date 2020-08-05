//
//  MockFetchImageService.swift
//  CityBrowserTests
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
@testable import CityBrowser

class MockFetchImageService: FetchCityImageService {
    
    var lastCityNameCalled: String?
    
    var completion: FetchCityImageServiceCompletion?
    
    func call(cityName: String, completion: @escaping FetchCityImageServiceCompletion) {
        lastCityNameCalled = cityName
        self.completion = completion
    }
    
    func sendMockOKResponse() {
        completion?(.success("image"))
    }
    
    func sendMockErrorResponse() {
        completion?(.failure(.jsonParseError))
    }
    
    
}
