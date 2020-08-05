//
//  Module.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

public struct ModuleDependencies {
    public var fetchCitiesService: FetchCitiesService
    public var fetchCityImageService: FetchCityImageService
    public var fetchRatingService: FetchRatingService
    public var fetchRecentVisitorsService: FetchRecentVisitorsService
    public var favoriteCitiesService: FavoriteCityService
    
    public init(fetchCitiesService: FetchCitiesService, fetchCityImageService: FetchCityImageService, fetchRatingService: FetchRatingService, fetchRecentVisitorsService: FetchRecentVisitorsService,favoriteCitiesService: FavoriteCityService) {
        self.fetchCitiesService = fetchCitiesService
        self.fetchCityImageService = fetchCityImageService
        self.fetchRatingService = fetchRatingService
        self.fetchRecentVisitorsService = fetchRecentVisitorsService
        self.favoriteCitiesService = favoriteCitiesService
    }
}
