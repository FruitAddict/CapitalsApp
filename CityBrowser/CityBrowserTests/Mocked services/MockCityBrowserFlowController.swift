//
//  MockCityBrowserFlowController.swift
//  CityBrowserTests
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
@testable import CityBrowser


class MockCityBrowserFlowController: CityBrowserFlowController {
    
    var lastSelectedCity: CityWrapper?
    
    var lastErrorMessage: String?
    
    var retryHandle: (() -> Void)?
    
    func start() {
        
    }
    
    func handleCitySelected(city: CityWrapper) {
        lastSelectedCity = city
    }
    
    func handleError(message: String, retryHandle: @escaping () -> Void) {
        lastErrorMessage = message
        self.retryHandle = retryHandle
    }
    
    
}
