//
//  CityWrapper.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

class CityWrapper {
    
    enum CityImageState {
        case initial
        case loading
        case error
        case fetched(base64: String)
    }
    
    enum CityDetailsState {
        case initial
        case error
        case fetched(CityDetails)
    }
    
    var city: City
    var isFavorite: Bool = false
    var imageState: CityImageState = .initial
    var cityDetailsState: CityDetailsState = .initial
    
    var imageBase64String: String? {
        if case .fetched(let string) = imageState {
            return string
        } else {
            return nil
        }
    }
    
    init(city: City) {
        self.city = city
    }
}
