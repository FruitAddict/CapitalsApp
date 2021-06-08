//
//  CityListPresenterImpl.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

final class CityListPresenterImpl: CityListPresenter {

    //MARK: - Services & Dependencies
    struct Dependencies {
        let flowController : CityBrowserFlowController
        let fetchCitiesService: FetchCitiesService
        let fetchImageService: FetchCityImageService
        let favoriteStore: FavoriteCityService
    }
    
    fileprivate weak var view : CityListView?
    
    fileprivate let flowController : CityBrowserFlowController
    
    fileprivate let fetchCitiesService: FetchCitiesService
    
    fileprivate let fetchImageService: FetchCityImageService
    
    fileprivate let favoriteStore: FavoriteCityService
    
    //MARK: - Properties
    fileprivate var cities: [CityWrapper] = []
    
    fileprivate var filteringEnabled = false
    
    fileprivate var filteredCities: [CityWrapper] {
        if filteringEnabled {
            return cities.filter { $0.isFavorite }
        } else {
            return cities
        }
    }
    
    fileprivate var viewModels: [CityViewModel] {
        return filteredCities.map {
            CityViewModel(captitalCityName: $0.city.capital,
                          country: $0.city.name,
                          isFavorite: $0.isFavorite,
                          imageBase64String: $0.imageBase64String)
        }
    }
    
    //MARK: - Initialization
    init(with dependencies: Dependencies) {
        self.fetchCitiesService = dependencies.fetchCitiesService
        self.flowController = dependencies.flowController
        self.fetchImageService = dependencies.fetchImageService
        self.favoriteStore = dependencies.favoriteStore
    }
    
    //MARK: - Service calls
    fileprivate func fetchCities() {
        view?.setActivityIndicatorVisibility(true)
        fetchCitiesService.call {
            result in
            
            self.view?.setActivityIndicatorVisibility(false)
            
            switch result {
            case .success(let cities):
                guard
                    !cities.isEmpty
                else {
                    return
                }
                self.cities = cities.map { CityWrapper(city: $0) }
                self.checkFavoriteCities()
                self.loadCitiesOnView()
                                
            case .failure(let error):
                let errorHandler: () -> Void = { [weak self] in
                    self?.fetchCities()
                }
                
                self.flowController.handleError(message: error.readableError, retryHandle: errorHandler)
                break
            }
        }
    }
    
    fileprivate func fetchImageForCity(cityWrapper: CityWrapper, index: Int) {
        cityWrapper.imageState = .loading
        fetchImageService.call(cityName: cityWrapper.city.capital) { result in
            switch result {
            case .success(let base64String):
                cityWrapper.imageState = .fetched(base64: base64String)
                self.softUpdateCity(atIndex: index)
                
            case .failure(_):
                cityWrapper.imageState = .error
            }
        }
    }
    
    fileprivate func checkFavoriteCities() {
        let storedCities = favoriteStore.getAllStoredCities()
        let citiesMap : [String:CityWrapper] = cities.reduce(into: [String: CityWrapper]()) {
            dict, city in
            dict[city.city.capital] = city
        }
        
        storedCities.forEach {
            storedCity in
            
            if let city = citiesMap[storedCity.name] {
                city.isFavorite = storedCity.isFavorite
            }
        }
    }
    
    //MARK: - Updating view
    fileprivate func loadCitiesOnView() {
        view?.setCityViewModels(viewModels)
    }
    
    fileprivate func softUpdateCity(atIndex index: Int) {
        view?.updateCityViewModels(newModels: viewModels, reloadingAtIndex: index)
    }
    
    fileprivate func softUpdateAllCities() {
        view?.updateCityViewModels(newModels: viewModels)
    }

    fileprivate func updateFilterStatusOnView() {
        view?.setFilteringEnabled(filteringEnabled)
    }
}

//MARK: - Events emitted from view
extension CityListPresenterImpl {
    
    func attach(view: CityListView) {
        self.view = view
    }
    
    func handleViewIsReady() {
        view?.setTitle("European Capitals")
        updateFilterStatusOnView()
        fetchCities()
    }
    
    func handleCityIsAboutToBeDisplayed(atIndex index: Int) {
        let city = filteredCities[index]
        
        switch city.imageState {
        case .error, .initial:
            fetchImageForCity(cityWrapper: city, index: index)
            
        default:
            break
        }
    }
    
    func handleCitySelected(atIndex index: Int) {
        let city = filteredCities[index]
        
        flowController.handleCitySelected(city: city)
    }

    func handleViewDidAppear() {
        if cities.count > 0 {
            checkFavoriteCities()
            if !filteringEnabled {
                softUpdateAllCities()
            } else {
                loadCitiesOnView()
            }
        }
    }
    
    func handleFilterButtonPressed() {
        filteringEnabled = !filteringEnabled
        loadCitiesOnView()
        updateFilterStatusOnView()
    }
}
