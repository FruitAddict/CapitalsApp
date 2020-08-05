//
//  CityBrowserTests.swift
//  CityBrowserTests
//
//  Created by Mateusz Popiało on 03/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import XCTest
@testable import CityBrowser

class CityListPresenterTests: XCTestCase {

    //MARK: - System under test
    var cityListPresenterUnderTest: CityListPresenterImpl!
    
    //MARK: - Mocks&Stubs
    var mockView: MockCityListView!
    
    var mockFlowController: MockCityBrowserFlowController!
    
    var mockFetchCitiesService: MockFetchCitiesService!
    
    var mockFetchImageService: MockFetchImageService!
    
    var mockFavStore: MockFavoriteStore!
    
    override func setUp() {
        mockFlowController = MockCityBrowserFlowController()
        
        mockView = MockCityListView()
        
        mockFetchCitiesService = MockFetchCitiesService()
        
        mockFetchImageService = MockFetchImageService()
        
        mockFavStore = MockFavoriteStore()
        
        cityListPresenterUnderTest = CityListPresenterImpl(with:
            .init(
            flowController: mockFlowController,
            fetchCitiesService: mockFetchCitiesService,
            fetchImageService: mockFetchImageService,
            favoriteStore: mockFavStore
            )
        )
        
        cityListPresenterUnderTest.attach(view: mockView)
    }

    func testPresenterCorrectlyLoadsCitiesInitially() {
        cityListPresenterUnderTest.handleViewIsReady()
        
        XCTAssert(mockView.activityIndicatorVisible == true)
        
        XCTAssert(mockFavStore.getAllStoredCitiesCalled == false)
        
        mockFetchCitiesService.sendMockOKResponse()
        
        XCTAssert(mockView.activityIndicatorVisible == false)
        
        XCTAssert(mockFavStore.getAllStoredCitiesCalled == true)
        
        XCTAssert(mockView.currentViewModels.count == 1)
    }
    
    func testPresenterCorrectlyReactsToErrors() {
        cityListPresenterUnderTest.handleViewIsReady()

        XCTAssert(mockView.activityIndicatorVisible == true)
        
        mockFetchCitiesService.sendMockErrorResponse()

        XCTAssert(mockView.activityIndicatorVisible == false)

        XCTAssert(mockFlowController.lastErrorMessage != nil)
        
        XCTAssert(mockView.currentViewModels.count == 0)
        
        mockFlowController.retryHandle?()
        
        XCTAssert(mockView.activityIndicatorVisible == true)

        mockFetchCitiesService.sendMockOKResponse()

        XCTAssert(mockView.activityIndicatorVisible == false)
        
        XCTAssert(mockView.currentViewModels.count == 1)
    }

    func testPresenterCorrectlyFetchesImages() {
        cityListPresenterUnderTest.handleViewIsReady()

        mockFetchCitiesService.sendMockOKResponse()

        cityListPresenterUnderTest.handleCityIsAboutToBeDisplayed(atIndex: 0)
        
        XCTAssert(mockFetchImageService.lastCityNameCalled == "Warsaw")
        
        mockFetchImageService.sendMockOKResponse()
        
        XCTAssert(mockView.currentViewModels[0].imageBase64String != nil)
    }
    
    func testPresenterCorrectlyIgnoresImageFetchFailure() {
        cityListPresenterUnderTest.handleViewIsReady()

        mockFetchCitiesService.sendMockOKResponse()

        cityListPresenterUnderTest.handleCityIsAboutToBeDisplayed(atIndex: 0)
        
        mockFetchImageService.sendMockErrorResponse()

        XCTAssert(mockFlowController.lastErrorMessage == nil)
    }
    
    func testPresenterCorrectlyRoutesToCityDetails() {
        cityListPresenterUnderTest.handleViewIsReady()

        mockFetchCitiesService.sendMockOKResponse()
        
        cityListPresenterUnderTest.handleCitySelected(atIndex: 0)
        
        XCTAssert(mockFlowController.lastSelectedCity?.city.capital == "Warsaw")
    }
    
    func testPresenterCorrectlyHandlesFiltering() {
        cityListPresenterUnderTest.handleViewIsReady()

        mockFetchCitiesService.sendMockOKResponse2()
        
        XCTAssert(mockView.currentViewModels.count == 2)
        
        cityListPresenterUnderTest.handleFilterButtonPressed()
        
        XCTAssert(mockView.currentViewModels.count == 0)
    }
    
    func testPresenterCorrectlyReactsToPersistentStoreChanges() {
        cityListPresenterUnderTest.handleViewIsReady()

        mockFetchCitiesService.sendMockOKResponse2()
        
        mockFavStore.makeFavCities()
        
        cityListPresenterUnderTest.handleViewDidAppear()
        
        XCTAssert(mockView.currentViewModels.count == 2)
        
        cityListPresenterUnderTest.handleFilterButtonPressed()
        
        XCTAssert(mockView.currentViewModels.count == 1)
        
    }
}
