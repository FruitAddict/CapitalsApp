//
//  MockCityListView.swift
//  CityBrowserTests
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
@testable import CityBrowser

class MockCityListView: CityListView {
    
    var activityIndicatorVisible: Bool = false
    
    var currentViewModels: [CityViewModel] = []
    
    var lastReloadedIndex: Int = -1
    
    var filteringEnabled: Bool = false
    
    func setActivityIndicatorVisibility(_ visible: Bool) {
        activityIndicatorVisible = visible
    }
    
    func setCityViewModels(_ models: [CityViewModel]) {
        currentViewModels = models
    }
    
    func updateCityViewModels(newModels models: [CityViewModel], reloadingAtIndex index: Int) {
        currentViewModels = models
        lastReloadedIndex = index
    }
    
    func updateCityViewModels(newModels models: [CityViewModel]) {
        currentViewModels = models
    }
    
    func setTitle(_ title: String) {
        
    }
    
    func setFilteringEnabled(_ filteringEnabled: Bool) {
        self.filteringEnabled = filteringEnabled
    }
    
    
}
