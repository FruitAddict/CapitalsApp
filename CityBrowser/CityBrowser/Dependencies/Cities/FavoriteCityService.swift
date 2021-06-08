//
//  FavoriteCityService.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

public protocol FavoriteCityService {
    func getAllStoredCities() -> [FavoriteCity]
    
    func setFavoriteCity(name: String, isFavorite: Bool)
}
