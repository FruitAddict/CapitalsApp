//
//  Constants.swift
//  Capitals
//
//  Created by Mateusz Popiało on 04/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

//MARK: Constants namespace
enum Constants {
    
    enum Networking {
        static var baseURL: String? {
            return Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String
        }
    }
    
}
