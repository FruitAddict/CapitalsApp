//
//  Result.swift
//  Common
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

public enum CapitalsError: Error {
    case jsonParseError
    case requestParseError
    case other(localizedDescription: String)
    
    public var readableError: String {
        switch self {
        case .other(let desc):
            return desc
            
        default:
            return "Please try again later"
        }
    }
}
