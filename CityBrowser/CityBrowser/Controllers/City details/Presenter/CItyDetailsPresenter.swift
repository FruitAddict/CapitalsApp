//
//  CItyDetailsPresenter.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

protocol CityDetailsPresenter: class {
    
    func attach(view: CityDetailsView)

    func handleViewIsReady()
        
    func handleFavoriteFlagChanged(_ newState: Bool)
}
