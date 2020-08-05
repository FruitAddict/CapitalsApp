//
//  CityDetailsView.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

protocol CityDetailsView: class {
        
    func setTitle(_ title: String)
    
    func setViewModel(_ viewModel: CityDetailsViewModel) 

}
