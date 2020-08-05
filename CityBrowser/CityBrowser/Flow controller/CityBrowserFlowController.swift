//
//  CityBrowserFlowController.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import UIKit
import Common

protocol CityBrowserFlowController: class {
    func start()
    
    func handleCitySelected(city: CityWrapper)
    
    func handleError(message: String,retryHandle: @escaping () -> Void)
}

public class CityBrowserFlowControllerImpl: CityBrowserFlowController {
    
    //MARK: - Module dependencies
    private var dependencies: ModuleDependencies
    
    private var navigationController: UINavigationController

    public init(withDependencies dependencies: ModuleDependencies, onNavigationController navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    //MARK: - Starting the module
    public func start() {
        Log.success("City browser flow was started.")
        
        let controller = makeCityListViewController()
        navigationController.pushViewController(controller, animated: false)
    }
    
    func handleCitySelected(city: CityWrapper) {
        let controller = makeCityDetailsViewController(forCity: city)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func handleError(message:String, retryHandle: @escaping () -> Void) {
        let errorController = makeErrorController(message: message, retryHandle: retryHandle)
        errorController.modalPresentationStyle = .fullScreen
        navigationController.present(errorController, animated: true, completion: nil)
    }

}

//MARK: - Creating ViewControllers
extension CityBrowserFlowControllerImpl {
    
    fileprivate func makeCityListViewController() -> UIViewController {
        let controller = CityListViewController()
        
        let presenter = CityListPresenterImpl(with:
            .init(
                flowController: self,
                fetchCitiesService: dependencies.fetchCitiesService,
                fetchImageService: dependencies.fetchCityImageService,
                favoriteStore: dependencies.favoriteCitiesService
            )
        )
        
        controller.setPresenter(presenter)
        
        return controller
    }
    
    fileprivate func makeCityDetailsViewController(forCity city: CityWrapper) -> UIViewController {
        let controller = CityDetailsViewController()
        
        let presenter = CityDetailsPresenterImpl(with:
            .init(
                flowController: self,
                city: city,
                detailsService: FetchCityDetailsServiceImpl(fetchRatingService: dependencies.fetchRatingService, fetchVisitorsService: dependencies.fetchRecentVisitorsService),
                favoriteCityService: dependencies.favoriteCitiesService
            )
        )
        
        controller.setPresenter(presenter)

        return controller
    }
    
    fileprivate func makeErrorController(message: String, retryHandle: @escaping () -> Void) -> UIViewController {
        let controller = ErrorViewController()
        
        let presenter = ErrorPresenterImpl(with:
            .init(
                retryHandle: retryHandle,
                errorMessage: message
            )
        )
        
        controller.setPresenter(presenter)

        return controller
    }
}
