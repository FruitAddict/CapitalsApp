//
//  ErrorPresenter.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

protocol ErrorPresenter : class {
    
    func attach(view: ErrorView)

    func handleViewIsReady()
    
    func handleRetryButtonPressed()
    
}
