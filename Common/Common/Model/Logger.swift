//
//  Logger.swift
//  Common
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

public protocol Logger {
    func info(_ log: String)
    func success(_ log: String)
    func error(_ log: String)
}
