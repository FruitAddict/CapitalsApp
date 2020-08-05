//
//  CityListView.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

protocol CityListView: class {
    
    func setActivityIndicatorVisibility(_ visible: Bool)

    func setCityViewModels(_ models: [CityViewModel])
    
    func updateCityViewModels(newModels models: [CityViewModel], reloadingAtIndex index: Int)
    
    func updateCityViewModels(newModels models: [CityViewModel])

    func setTitle(_ title: String)
    
    func setFilteringEnabled(_ filteringEnabled: Bool)
    
}
