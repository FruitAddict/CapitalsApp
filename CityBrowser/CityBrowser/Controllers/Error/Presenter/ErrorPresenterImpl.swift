//
//  ErrorPresenterImpl.swift
//  CityBrowser
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation

final class ErrorPresenterImpl: ErrorPresenter {
    
    typealias RetryHandle = () -> Void

    struct Dependencies {
        var retryHandle: RetryHandle
        var errorMessage: String
    }

    //MARK: - Services & Dependebcies
    fileprivate weak var view : ErrorView?

    fileprivate var retryHandle: RetryHandle?
    
    fileprivate var errorMessage: String
    
    //MARK: - Initialization
    init(with dependencies: Dependencies) {
        retryHandle = dependencies.retryHandle
        errorMessage = dependencies.errorMessage
    }
}


//MARK: - Events emitted from view
extension ErrorPresenterImpl {
    
    func attach(view: ErrorView) {
        self.view = view
    }
    
    func handleViewIsReady() {
        view?.setData(title: "Oops!", message: errorMessage)
    }
    
    func handleRetryButtonPressed() {
        view?.dismiss {
            self.retryHandle?()
        }
    }
}
