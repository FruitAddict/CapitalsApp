//
//  CityDetailsViewModel.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

struct CityDetailsViewModel {
    
    enum LoadableProperty {
        case initial
        case loading
        case loaded(String)
        case error
    }
    var country: String
    var cityName: String
    var imageBase64: String?
    var numberOfVisitors: LoadableProperty
    var rating: LoadableProperty
    var isFavorite: Bool
}
