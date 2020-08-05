//
//  FetchCityDetailsServiceImpl.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

class FetchCityDetailsServiceImpl: FetchCityDetailsService {
    
    //MARK: - Services
    private let fetchRatingService: FetchRatingService
    
    private let fetchVisitorsService: FetchRecentVisitorsService
    
    //MARK: - Initilization
    init(fetchRatingService: FetchRatingService, fetchVisitorsService: FetchRecentVisitorsService) {
        self.fetchRatingService = fetchRatingService
        self.fetchVisitorsService = fetchVisitorsService
    }
    
    func fetchCityDetails(forCity city: String, completion: @escaping FetchCityDetailsServiceCompletion) {
        let dispatchGroup = DispatchGroup()
        
        var cityRating: CityRating?
        var cityVisitorList: CityVisitorList?
        
        dispatchGroup.enter()
        fetchRatingService.call(cityName: city) {
            result in
            
            switch result {
            case .success(let rating):
                cityRating = rating
                
            case .failure(_):
                cityRating = nil
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchVisitorsService.call(cityName: city) {
            result in
            switch result {
            case .success(let list):
                cityVisitorList = list
                     
            case .failure(_):
                cityVisitorList = nil
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard
                let rating = cityRating,
                let visitorList = cityVisitorList
            else {
                completion(.failure(.other(localizedDescription: "One of the details services failed.")))
                return
            }
            
            completion(.success(.init(visitorList: visitorList, rating: rating)))
        }
    }
    
    
}
