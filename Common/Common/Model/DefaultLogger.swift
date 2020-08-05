//
//  DefaultLogger.swift
//  Common
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import os

public typealias Log = DefaultLogger

public class DefaultLogger: Logger {
    
    private init() {}
    
    public static let shared = DefaultLogger()
    
    public func info(_ log: String) {
        
        let bundleID:String = Bundle.main.bundleIdentifier ?? "unknown"
        let oslog = OSLog(subsystem: bundleID, category: "info")
        os_log("%@", log: oslog, type: .default, "👷🏻 \(log)")
    }
    
    public func success(_ log: String) {
        let bundleID:String = Bundle.main.bundleIdentifier ?? "unknown"
        let oslog = OSLog(subsystem: bundleID, category: "success")
        os_log("%@", log: oslog, type: .default, "✅ \(log)")
    }
    
    public func error(_ log: String) {
        let bundleID:String = Bundle.main.bundleIdentifier ?? "unknown"
        let oslog = OSLog(subsystem: bundleID, category: "error")
        os_log("%@", log: oslog, type: .default, "❌ \(log)")
    }
    
    //MARK: - Helpers
    public static func info(_ log: String) {
        shared.info(log)
    }
    
    public static func success(_ log: String) {
        shared.success(log)
    }
    
    public static func error(_ log: String) {
        shared.error(log)
    }
    
}
