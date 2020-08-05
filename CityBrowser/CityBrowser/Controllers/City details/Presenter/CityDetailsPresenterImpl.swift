//
//  CityDetailsPresenterImpl.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

final class CityDetailsPresenterImpl: CityDetailsPresenter {

    //MARK: - Services & Dependencies
    struct Dependencies {
        let flowController : CityBrowserFlowController
        let city: CityWrapper
        let detailsService: FetchCityDetailsService
        let favoriteCityService: FavoriteCityService
    }

    fileprivate weak var view : CityDetailsView?
    
    fileprivate let flowController : CityBrowserFlowController
    
    fileprivate let detailsService: FetchCityDetailsService
    
    fileprivate let favoriteCityService: FavoriteCityService

    fileprivate let city: CityWrapper
        
    //MARK: - Initialization
    init(with dependencies: Dependencies) {
        self.city = dependencies.city
        self.flowController = dependencies.flowController
        self.detailsService = dependencies.detailsService
        self.favoriteCityService = dependencies.favoriteCityService
    }

    //MARK: - Service calls
    fileprivate func fetchCityDetailsIfNeeded() {
        
        updateView()
        
        guard
            case .fetched(_) = city.cityDetailsState
        else {
            fetchCityDetails()
            return
        }
        
    }
    
    private func fetchCityDetails() {
        
        detailsService.fetchCityDetails(forCity: city.city.capital) {
            result in
            
            switch result {
            case .success(let details):
                self.city.cityDetailsState = .fetched(details)
                self.updateView()
                
            case .failure(_):
                self.city.cityDetailsState = .error
                
            }
        }
    }
    
    
    //MARK: - Updating view
    private func updateView() {
        let viewModel: CityDetailsViewModel
        
        switch city.cityDetailsState {
        case .initial:
            viewModel = CityDetailsViewModel(
                country: city.city.name,
                cityName: city.city.capital,
                imageBase64: city.imageBase64String,
                numberOfVisitors: .loading,
                rating: .loading,
                isFavorite: city.isFavorite
            )
            
        case .error:
            viewModel = CityDetailsViewModel(
                country: city.city.name,
                cityName: city.city.capital,
                imageBase64: city.imageBase64String,
                numberOfVisitors: .error,
                rating: .error,
                isFavorite: city.isFavorite
            )
            
        case .fetched(let details):
            viewModel = CityDetailsViewModel(
                country: city.city.name,
                cityName: city.city.capital,
                imageBase64: city.imageBase64String,
                numberOfVisitors: .loaded("\(details.visitorList.visitors.count)"),
                rating: .loaded(details.rating.rating),
                isFavorite: city.isFavorite
            )
        }
        
        view?.setViewModel(viewModel)
    }
}


//MARK: - Events emitted from view
extension CityDetailsPresenterImpl {
    
    func attach(view: CityDetailsView) {
        self.view = view
    }

    func handleViewIsReady() {
        view?.setTitle("Details")
        fetchCityDetailsIfNeeded()
    }
    
    func handleFavoriteFlagChanged(_ newState: Bool) {
        self.favoriteCityService.setFavoriteCity(name: city.city.capital, isFavorite: newState)
        self.city.isFavorite = newState
        updateView()
    }
}
