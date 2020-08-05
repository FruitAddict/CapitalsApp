//
//  FavoriteCityServiceImpl.swift
//  Capitals
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import CityBrowser
import PersistentStore

class FavoriteCityServiceImpl: FavoriteCityService {
    
    private var store: PersistentStore
    
    init(withStore store: PersistentStore) {
        self.store = store
    }
    
    func getAllStoredCities() -> [FavoriteCity] {
        let cities = store.fetchAllPersistedCityData()
        return cities.map({ FavoriteCity(name: $0.name, isFavorite: $0.isFavorite) })
    }
    
    func setFavoriteCity(name: String, isFavorite: Bool) {
        store.updateCityData(name: name, isFavorite: isFavorite)
    }
}
