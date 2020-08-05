//
//  ErrorView.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

protocol ErrorView: class {
        
    func setData(title: String, message: String)
    
    func dismiss(completion: @escaping () -> Void) 
}
