//
//  MockFavoriteStore.swift
//  CityBrowserTests
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
@testable import CityBrowser

class MockFavoriteStore: FavoriteCityService {
    
    var getAllStoredCitiesCalled = false
    
    var favCities: [FavoriteCity] = []
    
    func getAllStoredCities() -> [FavoriteCity] {
        getAllStoredCitiesCalled = true
        return favCities
    }
    
    func makeFavCities() {
        favCities = [.init(name: "Warsaw", isFavorite: true)]
    }
    
    func setFavoriteCity(name: String, isFavorite: Bool) {
        
    }
    
    
}
