//
//  AppDelegate.swift
//  Capitals
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import UIKit
import CityBrowser
import Common
import Networking
import PersistentStore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Properties
    fileprivate var databasePath: String? {
        let fileManager = FileManager.default

        guard
            let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        else {
            return nil
        }
        
        let databaseURL = documentDirectory.appendingPathComponent("cities_db.sqlite")
        return databaseURL.absoluteString
    }
    
    //MARK: - AppDelegate
    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        configureAndRunApp()
        
        Log.success("The app launched successfully.")
        
        return true
    }
    
    //MARK: - Running Flows
    private func configureAndRunApp() {
        
        let navigationController = UINavigationController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
        launchCityBrowserFlow(onNavController: navigationController)
    }
    
    private func launchCityBrowserFlow(onNavController navigationController: UINavigationController) {
        guard
            let baseURL = Constants.Networking.baseURL
        else {
            fatalError("Please specify base URL in the info.plist file")
        }
        
        guard
            let databasePath = databasePath
        else {
            fatalError("Please specify valid path for the database file")
        }
               
        let networkingService = DefaultNetworkingService(baseURL: baseURL)
               
        let fetchCitiesService = FetchCitiesServiceImpl(networkingService: networkingService)
               
        let fetchImageService = FetchCityImageServiceImpl(networkingService: networkingService)
               
        let ratingService = FetchRatingServiceImpl(networkingService: networkingService)
               
        let visitorsService = FetchRecentVisitorsServiceImpl(networkingService: networkingService)

        let favoriteCityService = FavoriteCityServiceImpl(withStore: DefaultPersistentStore(path: databasePath))
               
        let moduleDependencies = CityBrowser.ModuleDependencies(
            fetchCitiesService: fetchCitiesService,
            fetchCityImageService: fetchImageService,
            fetchRatingService: ratingService,
            fetchRecentVisitorsService: visitorsService,
            favoriteCitiesService: favoriteCityService
        )
        
        let flowController = CityBrowserFlowControllerImpl(withDependencies: moduleDependencies, onNavigationController: navigationController)
        flowController.start()
    }

}

