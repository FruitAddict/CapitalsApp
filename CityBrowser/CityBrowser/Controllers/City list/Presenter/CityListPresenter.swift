//
//  CityListPresenter.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

protocol CityListPresenter: class {
    
    func attach(view: CityListView)

    func handleViewIsReady()
    
    func handleCityIsAboutToBeDisplayed(atIndex index: Int)
    
    func handleCitySelected(atIndex index: Int)
    
    func handleViewDidAppear()
    
    func handleFilterButtonPressed()
}


