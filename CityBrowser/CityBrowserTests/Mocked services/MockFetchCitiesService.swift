//
//  MockFetchCitiesService.swift
//  CityBrowserTests
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
@testable import CityBrowser

class MockFetchCitiesService: FetchCitiesService {
    
    var completion: FetchCitiesServiceCompletion?
    
    func call(completion: @escaping FetchCitiesServiceCompletion) {
        self.completion = completion
    }
    
    func sendMockOKResponse() {
        completion?(.success([.init(name: "Poland", capital: "Warsaw")]))
    }
    
    func sendMockErrorResponse() {
        completion?(.failure(.jsonParseError))
    }
    
    func sendMockOKResponse2() {
        completion?(.success([
            .init(name: "Poland", capital: "Warsaw"),
            .init(name: "Russia", capital: "Moscov")
        ]))

    }
}
