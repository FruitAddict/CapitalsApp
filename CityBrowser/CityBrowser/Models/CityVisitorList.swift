//
//  CityVisitorList.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

public struct CityVisitorList: Codable {
    var visitors: [CityVisitor]
}

public struct CityVisitor: Codable {
    var name: String
}
