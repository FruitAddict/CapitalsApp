//
//  FavoriteCity.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

public struct FavoriteCity {
    var name: String
    var isFavorite: Bool
    
    public init(name: String, isFavorite: Bool) {
        self.name = name
        self.isFavorite = isFavorite
    }
}
